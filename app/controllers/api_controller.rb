class ApiController < ActionController::Base
  def require_login!
    return true if authenticate_token
    errors = { errors: [ { detail: "Access denied" } ] }
    render json: errors, status: :unauthorized
  end
      
  def current_user
    @current_user ||= authenticate_token
  end
  
  private
  
  def authenticate_token
    authenticate_with_http_token do |token, options|
      User.find_by(auth_token: token)
    end
  end
end