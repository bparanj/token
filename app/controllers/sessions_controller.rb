class SessionsController < ApiController
  skip_before_action :require_login!, only: [:create], raise: false

  def create
    user = User.valid_login?(params[:user_login][:email], params[:user_login][:password])
    if user
      # token must be allowed to be used only once
      user.regenerate_auth_token
      render json: { auth_token: user.auth_token }
    else
      invalid_login_attempt
    end
  end

  def destroy
    resource = current_user
    resource.invalidate_auth_token
    head :ok
  end

  private
  
  def invalid_login_attempt
    render json: { errors: [ { detail:"Error with your login or password" }]}, status: :unauthorized
  end
  
end
