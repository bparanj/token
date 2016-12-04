class SessionsController < ApiController
  skip_before_action :require_login!, only: [:create], raise: false

  def create
    resource = User.find_for_database_authentication(:email => params[:user_login][:email])
    return invalid_login_attempt unless resource

    if resource.authenticate(params[:user_login][:password])
      auth_token = resource.regenerate_auth_token
      render json: { auth_token: resource.auth_token }
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
    render json: { errors: [ { detail:"Error with your login or password" }]}, status: 401
  end
  
end
