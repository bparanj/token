# Watch the Screencast

How to build token based API authentication without using any bloated authentication gem.

[![Securing an API in Rails 5 using Token Based API Authentication](https://www.rubyplus.com/images/RAILS-res-3000px-winning-purple.png)](https://www.rubyplus.com/episodes/191-Securing-an-API-using-Token-Based-Authentication-in-Rails-5)

must be allowed to be used only once
should have an expiry date (e.g. 7 days)
must only be usable for the user it was created for
must only be sent via HTTPS

1. Create a migration with token_created_at field.
$ rails g migration add_token_created_at_to_users token_created_at:datetime
class AddTokenCreatedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token_created_at, :datetime
    remove_index :users, :auth_token
    add_index :users, [:auth_token, :token_created_at]
  end
end
2. Touch this field whenever a token is generated.

def generate_auth_token
    token = SecureRandom.hex
    self.update_columns(auth_token: token, token_created_at: Time.zone.now)
    token
  end

  def invalidate_auth_token
    self.update_columns(auth_token: nil, token_created_at: nil)
  end
  
3. In base controller:
def authenticate_token
  authenticate_with_http_token do |token, options|
    User.where(auth_token: token).where("token_created_at >= ?", 7.days.ago).first
  end
end

Decoded URL:
user_login[email]=jon2@mccartie.com&user_login[password]=123456

email=jon2@mccartie.com&password=123456

curl -X POST --data "email%3Djon2%40mccartie.com%26password%3D123456" http://localhost:3000/sign-in.json

curl -X DELETE -H "Authorization: Token token=" http://localhost:3000/sign-out.json
curl -H "Authorization: Token token=" http://localhost:3000/hacker_spots/index.json





curl -X POST --data "email%3Djon2%40mccartie.com%26password%3D123456" http://localhost:3000/sign-in.json
curl -H "Authorization: Token token=" http://localhost:3000/hacker_spots/index.json
curl -X DELETE -H "Authorization: Token token=" http://localhost:3000/sign-out.json

1. password_digest string attribute to User
2. gem 'bcrypt', '~> 3.1.7'
3. 

class User < ActiveRecord::Base
  has_secure_password
end


https://github.com/robertomiranda/has_secure_token

Adds methods to set and authenticate against a BCrypt password. This mechanism requires you to have a password_digest attribute.

The following validations are added automatically:

Password must be present on creation
Password length should be less than or equal to 72 characters

Example using Active Record (which automatically includes ActiveModel::SecurePassword):

Schema: 


user = User.new(name: 'david', password: '')
user.save                                                 # => false, password required
user.password = 'mUc3m00RsqyRe'
user.save                                                 # => true
user.authenticate('notright')                             # => false
user.authenticate('mUc3m00RsqyRe')                              # => user
User.find_by(name: 'david').try(:authenticate, 'notright')      # => false
User.find_by(name: 'david').try(:authenticate, 'mUc3m00RsqyRe') # => user


