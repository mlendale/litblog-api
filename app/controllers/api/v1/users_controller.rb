class Api::V1::UsersController < ApplicationController
 before_filter :load_user, :only => [:show, :update, :destroy]
 
 def index
    users=User.all
    render jsonapi: users, each_serializer: UserSerializer, root: 'users', status: :ok
 end
 
 #Show one user. For testing but will not be used.
 def show    
    render jsonapi: @user, serializer: UserSerializer
 end
 
# Create user
 def create
   user = User.new(user_params)
   respond_to do |format|
     if user.save
       render jsonapi: user, serializer: UserSerializer, status: :created
     else
       #render jsonapi: user.errors, status: :unprocessable_entity 
       render jsonapi: user, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
     end
   end
 end

# Update user
 def update
     if @user.update_attributes(user_params)
       @user.reload #Is it needed?
       render jsonapi: @user, status: :ok
     else
       render jsonapi: user, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
       #render jsonapi: @user.errors, status: :unprocessable_entity 
     end
 end


 private
   # Only allow a trusted parameter "white list" through.
 def user_params
   ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:name, :email, :password, :password_confirmation] )
 end

 def load_user
   @user = User.find_by(name: params[:id])
   render jsonapi: @user, status: :not_found , serializer: ActiveModel::Serializer::ErrorSerializer unless @user.present?
 end

end

