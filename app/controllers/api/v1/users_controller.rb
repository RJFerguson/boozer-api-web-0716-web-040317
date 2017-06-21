class Api::V1::UsersController < ApplicationController

  def index
    # list all of the users
    users = User.all
    render json: users 
  end

 
end
