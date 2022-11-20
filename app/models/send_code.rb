require 'twilio-ruby'

class SendCode
  def initialize
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    @from = ENV['FROM_MOBILE_NUMBER']
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  def send_sms(options = {})
    # @client.messages.create(to: options[:to], body: options[:body], from: @from)
  end
end
