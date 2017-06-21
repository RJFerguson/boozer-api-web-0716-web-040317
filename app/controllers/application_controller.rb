class ApplicationController < ActionController::API
  private

  def authorize_user!
      if !current_user.present?
        render json: {error: "No user"}
      end
  end

  def current_user
    @current_user ||= User.find_by(id: user_id)
  end

  def token
    request.headers['Authorization']
  end

  def user_id
    decoded_token.first['user_id']
  end

  def decoded_token
    if token
      begin
        JWT.decode(token, ENV['JWT_SECRET'], true, {alogrithm: false})
      rescue JWT::DecodeError
        return [{}]
      end
    else
      [{}]
    end
  end


end
