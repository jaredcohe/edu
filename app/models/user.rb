class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :password, :password_confirmation
  validates_uniqueness_of :email
  before_create { generate_token(:auth_token) }
  
  def generate_token(column)
    begin
      p self
      p "0000000000000"
      p self[column]
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
