class ApiController < ActionController::Base
  def require_login!
    return true if authenticate_token
    render json: { errors: [ { detail: "Access denied" } ] }, status: 401
  end
    
  def user_signed_in?
    current_person.present?
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