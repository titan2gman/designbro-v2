# frozen_string_literal: true

require 'mailchimp'

RSpec.describe MailchimpSubscriber do
  describe '#call' do
    it 'sends subscribe requests' do
      user = create(:user, email: 'dallin.rempel@effertz.info')
      create(:designer, user: user)

      stub_subscribe

      response = MailchimpSubscriber.new(user).call(true)

      expect(response['email']).to eq(user.email)
      expect(a_request(:post, /us15.api.mailchimp.com/)).to have_been_made.once
    end

    it 'sends unsubscribe requests' do
      user = create(:user, email: 'dallin.rempel@effertz.info')
      create(:designer, user: user)

      stub_unsubscribe

      response = MailchimpSubscriber.new(user).call(false)

      expect(response['complete']).to be true
      expect(a_request(:post, /us15.api.mailchimp.com/)).to have_been_made.once
    end
  end

  private

  def stub_subscribe
    stub_request(:post, 'https://us15.api.mailchimp.com/2.0/lists/subscribe.json')
      .with(body: '{"id":"test","email":{"email":"dallin.rempel@effertz.info"},"merge_vars":null,"email_type":"html","double_optin":false,"update_existing":false,"replace_interests":true,"send_welcome":false,"apikey":"test-us15"}',
            headers: { 'Content-Type' => 'application/json', 'Host' => 'us15.api.mailchimp.com:443', 'User-Agent' => 'excon/0.62.0' })
      .to_return(status: 200, body: '{"email":"dallin.rempel@effertz.info","euid":"test","leid":"test"}', headers: {})
  end

  def stub_unsubscribe
    stub_request(:post, 'https://us15.api.mailchimp.com/2.0/lists/unsubscribe.json')
      .with(body: '{"id":"test","email":{"email":"dallin.rempel@effertz.info"},"delete_member":true,"send_goodbye":true,"send_notify":true,"apikey":"test-us15"}',
            headers: { 'Content-Type' => 'application/json', 'Host' => 'us15.api.mailchimp.com:443', 'User-Agent' => 'excon/0.62.0' })
      .to_return(status: 200, body: '{"complete":true}', headers: {})
  end
end
