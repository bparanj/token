class SessionsController < ApiController
  skip_before_action :require_login!, only: [:create], raise: false

  def create
    if user = User.valid_login?(params[:user_login][:email], params[:user_login][:password])
      allow_token_to_be_used_only_once_for(user)
      send_auth_token_for_valid_login_of(user)
    else
      invalid_login_attempt
    end
  end

  def destroy
    logout
    head :ok
  end

  private
  
  def invalid_login_attempt
    errors = { errors: [ { detail:"Error with your login or password" }]}
    render json: errors, status: :unauthorized
  end

  def send_auth_token_for_valid_login_of(user)
    render json: { auth_token: user.auth_token }
  end
  
  def allow_token_to_be_used_only_once_for(user)
    user.regenerate_auth_token
  end
  
  def logout
    current_user.invalidate_auth_token
  end
end
