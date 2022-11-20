class User < ApplicationRecord
  require File.join File.dirname(__FILE__), 'send_code'

  has_secure_password
  has_one_time_password length: 6, counter_based: true
  has_one_attached :profile_picture
  validates :email, presence: true, uniqueness: true
  validates :mobile_number, uniqueness: true, presence: true

  validates :first_name, :last_name, presence: true

  def send_auth_code
    options = {
      to: mobile_with_code,
      body: "Your User Verification code is #{self.otp_code}. Please do not share it with anybody."
    }
    SendCode.new.send_sms(options)
  end

  def filter_password
    self.attributes.except('password_digest', 'otp_secret_key', 'otp_counter')
  end

  private

  def mobile_with_code
    self.country_code + self.mobile_number
  end
end
