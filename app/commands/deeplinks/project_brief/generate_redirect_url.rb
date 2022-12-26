# frozen_string_literal: true

module Deeplinks
  module ProjectBrief
    class GenerateRedirectUrl
      EXPIRED_REDIRECT_URL = '/errors/link-expired'

      attr_reader :token, :client_id, :uid, :redirect_url, :reminder

      def initialize(client)
        @client = client
        @user = client&.user
      end

      def build_abandoned_cart_redirect_url(project_id:, reminder:)
        @project_id = project_id
        @reminder = reminder

        @redirect_url = "#{ENV.fetch('ROOT_URL')}#{abandoned_cart_redirect_path}#{params}"
      end

      def build_retargeting_redirect_url(project_id:)
        @project_id = project_id

        @redirect_url = "#{ENV.fetch('ROOT_URL')}#{retargeting_redirect_path}#{params}"
      end

      def success?
        user.present?
      end

      def attach_discount_to_project
        if ['first_reminder', 'second_reminder'].include?(reminder)
          project.update(
            discount: AbandonedCartDiscount.first&.discount
          )
        end
      end

      private

      attr_reader :user, :token_hash, :expiry, :project_id

      def abandoned_cart_redirect_path
        if success?
          generate_auth_params
          add_new_token_to_user
          if project.product.key == 'logo2' && project.current_step
            "/new-project/#{project_id}/#{project.current_step.path}"
          else
            "/c/projects/#{project_id}"
          end
        else
          EXPIRED_REDIRECT_URL
        end
      end

      def retargeting_redirect_path
        if success?
          generate_auth_params
          add_new_token_to_user
        end

        if project&.draft?
          if project.product.key == 'logo2'
            "/new-project/#{project_id}/#{project.current_step.path}"
          else
            "/projects/#{project_id}/#{project.current_step.path}"
          end
        else
          '/c'
        end
      end

      def add_new_token_to_user
        user.tokens[client_id] = {
          token: token_hash,
          expiry: expiry
        }
        user.save!
      end

      def generate_auth_params
        @client_id  = SecureRandom.urlsafe_base64(nil, false)
        @token      = SecureRandom.urlsafe_base64(nil, false)
        @token_hash = BCrypt::Password.create(token)
        @expiry     = (Time.now + DeviseTokenAuth.token_lifespan).to_i
        @uid        = user.uid
      end

      def project
        @project ||= Project.find_by(id: project_id)
      end

      def params
        url_params = '?utm_source=designbro'
        url_params += "&utm_medium=email&utm_campaign=c_ac#{reminder_number}#{project.email_template_set_name}" if reminder
        url_params += "&utm_term=#{project_id}"

        url_params
      end

      def reminder_number
        case reminder
        when 'first_reminder'
          1
        when 'second_reminder'
          2
        else
          3
        end
      end
    end
  end
end
