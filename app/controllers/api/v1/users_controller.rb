class Api::V1::UsersController < ApplicationController
 before_action :load_user, :only => [:show]
  before_action :load_user_update, :only => [:update, :destroy]
 
 def index
    users=User.all
    render jsonapi: users, root: 'users', status: :ok
 end
 
 #Show one user. For testing but will not be used.
 def show    
    render jsonapi: @user, include: ["posts"]
 end
 
# Create user
 def create
   user = User.new(user_params)
   if user.save
     render jsonapi: user, serializer: UserSerializer, status: :created
   else
       #render jsonapi: user.errors, status: :unprocessable_entity 
     render jsonapi: user.errors, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
   end
  
 end

# Update user
 def update
     if @user.update_attributes(user_params)
       @user.reload #Is it needed?
       render jsonapi: @user, status: :ok
     else
       render jsonapi: @user, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
     end
 end


 private
   # Only allow a trusted parameter "white list" through.
 def user_params
   ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:name, :email, :password, :password_confirmation] )
 end

 def load_user
   render_not_found unless @user = User.find_by(name: params[:id])
   
 end
 
  def load_user_update
   render_not_found unless @user = User.find_by(id: params[:id])
 end
 
 def render_not_found
	render jsonapi: 'User not found', serializer: ActiveModel::Serializer::ErrorSerializer, status: :not_found
 end

end

