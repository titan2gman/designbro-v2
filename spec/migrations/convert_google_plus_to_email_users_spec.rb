# frozen_string_literal: true

RSpec.describe ConvertGooglePlusToEmailUsers do
  let!(:client_user_email)   { create(:user, email: 'client-email@gmail.com') }
  let!(:designer_user_email) { create(:user, email: 'designer-email@gmail.com') }

  let!(:client_email)   { create(:client,   user: client_user_email) }
  let!(:designer_email) { create(:designer, user: designer_user_email) }

  let!(:client_user_google_oauth2) do
    uid   = 'client_google_oauth2'
    email = 'client-google-oauth2@gmail.com'

    create(:user, provider: :google_oauth2, email: email, uid: uid)
  end

  let!(:designer_user_google_oauth2) do
    uid   = 'designer_google_oauth2'
    email = 'designer-google-oauth2@gmail.com'

    create(:user, provider: :google_oauth2, email: email, uid: uid)
  end

  let!(:client_google_oauth2)   { create(:client,   user: client_user_google_oauth2) }
  let!(:designer_google_oauth2) { create(:designer, user: designer_user_google_oauth2) }

  describe '#call' do
    it 'sends an email to every user with Google+' do
      [client_user_google_oauth2, designer_user_google_oauth2].each do |user|
        expect(UserMailer).to receive(:google_plus_functionality_removed).with(user: user)
                                                                         .and_return(double('mailer').tap { |mailer| expect(mailer).to receive(:deliver_later) })
      end

      ConvertGooglePlusToEmailUsers.new.change
    end

    it 'updates `uid` and `provider` for every user with Google+' do
      expect(User.where(provider: :email).count).to eq(2)
      expect(User.where(provider: :google_oauth2).count).to eq(2)

      ConvertGooglePlusToEmailUsers.new.change

      expect(User.where(provider: :email).count).to eq(4)
      expect(User.where(provider: :google_oauth2).count).to eq(0)

      expect(client_user_google_oauth2.reload.uid).to eq('client-google-oauth2@gmail.com')
      expect(designer_user_google_oauth2.reload.uid).to eq('designer-google-oauth2@gmail.com')
    end
  end
end
