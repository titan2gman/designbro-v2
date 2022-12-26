# frozen_string_literal: true

class DeeplinksController < Api::V1::ApplicationController
  before_action :fetch_client

  def continue_brief
    service.build_abandoned_cart_redirect_url(project_id: params[:project_id], reminder: params[:reminder])

    if service.success?
      set_auth_headers
      service.attach_discount_to_project
    end

    redirect_to service.redirect_url
  end

  def retargeting
    service.build_retargeting_redirect_url(project_id: cookies.encrypted[:project_id])

    set_auth_headers if service.success?

    redirect_to service.redirect_url
  end

  def stripe_callback
    service = StripeSuccessProjectPaymentCallback.new(params[:project_id], params[:session_id])
    service.call
    redirect_to service.redirect_url
  end

  private

  def set_auth_headers
    cookies.permanent.encrypted['signed_uid'] = service.uid
    cookies[DeviseTokenAuth.headers_names[:'access-token']] = service.token
    cookies[DeviseTokenAuth.headers_names[:'token-type']] = 'Bearer'
    cookies[DeviseTokenAuth.headers_names[:client]] = service.client_id
    cookies[DeviseTokenAuth.headers_names[:uid]] = service.uid
  end

  def fetch_client
    client_id = JsonWebToken.decode(params[:token])[:client_id]
    @client = Client.find_by(id: client_id)
  end

  def service
    @service ||= Deeplinks::ProjectBrief::GenerateRedirectUrl.new(@client)
  end
end
