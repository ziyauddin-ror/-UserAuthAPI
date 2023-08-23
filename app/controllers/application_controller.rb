class ApplicationController < ActionController::API
	before_action :set_current_user

  def set_current_user
    token = request.headers['Authorization']&.split(' ')&.last
    if token
      decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      user_id = decoded_token[0]['user_id']
      @current_user = User.find_by(id: user_id)
    end
  end

  def current_user
    @current_user
  end
end
