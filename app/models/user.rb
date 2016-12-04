class User < ApplicationRecord
  has_secure_token :auth_token
  has_secure_password
  
  def self.find_for_database_authentication(hash)
    User.find_by(email: hash[:email])
  end
    
 # This method is not available in has_secure_token
  def invalidate_auth_token
    self.update_columns(auth_token: nil)
  end
  
  def self.valid_login?(email, password)
    resource = find_for_database_authentication(:email => email)
    if resource && resource.authenticate(password)
      resource
    else
      false
    end
  end
end
