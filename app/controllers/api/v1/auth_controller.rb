class Api::V1::AuthController < ApplicationController
	def login
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base, 'HS256')
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def registration
    user = User.new(user_params)

    if user.save
      token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base, 'HS256')
      render json: { token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
