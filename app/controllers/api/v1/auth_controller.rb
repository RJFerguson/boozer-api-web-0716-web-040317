class Api::V1::AuthController < ApplicationController

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
        username: user.username
       }
     else
      # otherwise, render back some error response
      render json: {
        error: 'Username or password incorrect'
      }, status: 404
    end
  end
end 