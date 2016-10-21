class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  before_action :destroy_session
  
  attr_accessor :current_user
  
  
  protected
  def destroy_session
    request.session_options[:skip] = true
  end
  
  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    @user_email = options.blank?? nil : options[:email]
    @user = User.find_by(email: @user_email)

    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
      @current_user = @user
    else
      return unauthenticated!
    end
  end
  
  def unauthenticated!
    response.headers['WWW-Authenticate'] = "Token realm=Application"
    render jsonapi: 'Bad credentials', status: 401
  end
end
