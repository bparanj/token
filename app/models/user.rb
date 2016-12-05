class User < ApplicationRecord
  # customize the name of token to auth_token
  has_secure_token :auth_token
  has_secure_password
      
 # This method is not available in has_secure_token
  def invalidate_auth_token
    self.update_columns(auth_token: nil)
  end
  
  def self.valid_login?(email, password)
    user = find_by(email: email)
    if user && user.authenticate(password)
      user
    else
      false
    end
  end
end
