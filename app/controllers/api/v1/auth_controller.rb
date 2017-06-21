class Api::V1::AuthController < ApplicationController
  before_action :authorize_user!, only: [:show]

  def show
    render json: {
        id: current_user.id,
        username: current_user.username
       }
  end

  def create
    # hello ="hellow world"
    # render :json hello
    # see if there is a user with this username
     user = User.find_by(username: params[:username])
    # if there is, make sure that they have the correct password
    if user.present? && user.authenticate(params[:password])
       # if they do, render back a json response of the user info
       render json: {
        id: user.id,
        username: user.username,
        jwt: JWT.encode({user_id: user_id}, ENV['JWT_SECRET'], ENV['JWT_ALGO'])
       }
     else
      # otherwise, render back some error response
      render json: {
        error: 'Username or password incorrect'
      }, status: 404
    end
  end
end
