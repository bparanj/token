class SessionsController < ApiController
  skip_before_action :require_login!, only: [:create], raise: false

  def create
    user = User.valid_login?(params[:user_login][:email], params[:user_login][:password])
    if user
      # Allow token be used only once
      user.regenerate_auth_token
      render json: { auth_token: user.auth_token }
    else
      invalid_login_attempt
    end
  end

  def destroy
    current_user.invalidate_auth_token
    head :ok
  end

  private
  
  def invalid_login_attempt
    errors = { errors: [ { detail:"Error with your login or password" }]}
    render json: errors, status: :unauthorized
  end
  
end
