class Api::V1::SessionsController < ApplicationController
    def create
    user = User.find_by(email: params[:username])
    if user && user.authenticate(params[:password])
    self.current_user = user
    #Give back user ID as username can be edited
    render jsonapi: data={ user_id: user.id, access_token: user.authentication_token }, status: :created 
    else
      render jsonapi: "User not authorized", status: :unauthorized
    end
  end
end
