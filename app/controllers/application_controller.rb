class ApplicationController < ActionController::API
  def current_user
    @current_user ||= User.find_by(id: user_id)
  end

  def user_id
    request.headers['Authorization']
  end


end
