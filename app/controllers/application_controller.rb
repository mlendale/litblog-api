class ApplicationController < ActionController::API
  include Pundit
  include ActionController::MimeResponds
  include ActionController::RequestForgeryProtection
  
  #Allow to rescue from Pundit denied authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  #protect_from_forgery with: :null_session
  
  before_action :destroy_session

  
  attr_accessor :current_user
  
  
  protected
  def destroy_session
    request.session_options[:skip] = true
  end
  
  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
    user=User.find_by(authentication_token: token)

    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
      @current_user = user
    else
      return unauthenticated!
    end
  end
 
  def user_not_authorized
    render jsonapi: 'You are not authorized to perform this action', status: :forbidden, serializer: ActiveModel::Serializer::ErrorSerializer
  end
  
  def unauthenticated!
    response.headers['WWW-Authenticate'] = "Token realm=Application"
    render jsonapi: 'Bad credentials', status: :unauthorized , serializer: ActiveModel::Serializer::ErrorSerializer
  end
end
