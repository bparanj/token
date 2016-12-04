# README

How to build token based API authentication without using any bloated authentication gem.

curl -X POST --data "user_login%5Bemail%5D=jon2%40mccartie.com&user_login%5Bpassword%5D=123456" http://localhost:3000/sign-in.json

curl -X DELETE -H "Authorization: Token token=GUagGpYUhVgSLz7hgV9gnuMx" http://localhost:3000/sign-out.json
curl -H "Authorization: Token token=351d6d7402ac290deacf15f69e925cdf" http://localhost:3000/hacker_spots/index.json

curl -H "Authorization: Token token=y3X4bKSkHnSKaQrWsQLELj5D" http://localhost:3000/hacker_spots/index.json






curl -X DELETE -H "Authorization: Token token=y3X4bKSkHnSKaQrWsQLELj5D" http://localhost:3000/sign-out.json

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


