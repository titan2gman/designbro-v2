# frozen_string_literal: true

RSpec.describe Api::V1::WinnersController do
  let(:design) { create(:finalist_design) }

  let(:params) do
    {
      format: :json,
      design_id: design.id
    }
  end

  context 'client' do
    let(:user)    { create(:client).user }
    let(:headers) { user.create_new_auth_token }

    before { request.headers.merge! headers }

    context '#create' do
      it 'cancan does not allow :create' do
        @ability.cannot :read, Design
        patch :create, params: params

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  context 'designer' do
    let(:user)    { create(:designer).user }
    let(:headers) { user.create_new_auth_token }

    before { request.headers.merge! headers }

    context '#create' do
      it 'cancan does not allow :create' do
        @ability.cannot :read, Design
        post :create, params: params

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
