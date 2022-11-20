class UsersController < ApplicationController
  before_action :authorize_request, only: [:profile, :reset_password]
  before_action :set_user, only: [:login, :reset_password, :generate_otp, :validate_otp, :resend_otp]

  def registration
    user = User.new(user_params)
    if user.save
      render json: { user: user.filter_password }, status: 201
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def login
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def profile
    # Need to send wallet balance
    render json: {user: @current_user.filter_password}, status: 200
  end

  def reset_password
    if @user.update(password: params[:password])
      render json: { user: @user.filter_password }, status: 200
    else
      render json: { errors: @user.errors }, status: 422
    end
  end

  def generate_otp
    @user.send_auth_code
    render json: {user: @user.filter_password, message: 'otp sent to mobile number'}, status: 200
  end

  def validate_otp
    if @user.authenticate_otp(params[:otp_code], auto_increment: true)
      token = JsonWebToken.encode(user_id: @user.id)
      render json: {user: @user.filter_password, token: token, message: 'successfully validated otp code'}, status: 200
    else
      render json: {message: 'invalid otp code'}, status: 401
    end
  end

  def resend_otp
    @user.send_auth_code
    render json: {user: @user.filter_password, message: 'code resend successfully'}, status: 200
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :mobile_number, :country_code, :profile_picture)
  end

  def set_user
    @user = User.find_by(mobile_number: params[:mobile_number])
  rescue ActiveRecord::RecordNotFound
    render json: 'user not found', status: 400
  end
end
