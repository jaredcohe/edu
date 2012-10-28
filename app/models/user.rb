class User < ActiveRecord::Base
  # http://railscasts.com/episodes/250-authentication-from-scratch-revised
  has_secure_password
  attr_accessible :email, :password, :password_confirmation
  validates_uniqueness_of :email
end
