# Model Classes

class User
	attr_accessor: [:email, :password_digest, :first_name, :last_name, :country_code, :mobile_number]
	has_secure_password
	has_one :profile_picture, class_name: "Image"
	has_many :text_messages
	has_one :bank_account
	has_one :wallet
	has_many :transactions, through: :wallet
end

class Image
	attr_accessor: [:attachment, :user_id]
	belongs_to :user
end

class TextMessage
	attr_accessor: [:otp, :user_id, :created_at, :updated_at]
	belongs_to :user
	# for otp validation as otp will be invalid after 15 min.
end

class BankAccount
	attr_accessor: [:bank_name, :account_type, :ifsc_code, :name_on_account]
	belongs_to :user
end

# class QrCode
# 	attr_accessor: [:code, :amount, :link, :created_at, :updated_at, :bank_account_id]
# end

class Transaction
	attr_accessor: [:amount, :trasaction_id, :created_at, :updated_at, :bank_account_id, :wallet_id]
	belongs_to :bank_account
	belongs_to :wallet
end

class Wallet
	attr_accessor: [:balance, :user_id]
	belongs_to :user
	has_many :transactions
end


# Controller classes

class HomeController
	# before dashboard action verify logged in user and send account details for logged in user.
	def dashboard
	end

	def generate_qr_code
	end

	def transactions
		# validate request and return current user transactions
	end
end

class UsersController
	before_action :authentication_token  # Will be sent to application controller
	skip_before_action :authentication_token, only: [:login, :registration]
	def registration
	end

	def reset_password
		# update password with new password provided
	end

	def login
		# validate user mobile number and password and send the auth token
	end

	def generate_otp
		# generate otp and send in response, message_id an otp.
	end

	def validate_otp
		# once user otp is validated, sign in the user and redirect to homepage dashboard
	end

	def check_wallet_balance
		# authenticate user and return user wallet balance
	end
end


def BankAccountController

	def create
	end

	def delete
	end

	def withdraw_from_wallet
	end
end




# Apis



# Bank account verification ?
# Transaction from where to where ?
# QR code generation with which attributes ?



https://docs.google.com/document/d/1jS6ZOJjL_rGqLKphTZ0vf93Ljzpknd4Mfv17wyMA6dc/edit?usp=sharing


How the QR code 