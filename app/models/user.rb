class User < ApplicationRecord
  has_secure_password
  
  validates_presence_of :first_name, :last_name, :username, :email, :phone_number, :password
  validates_uniqueness_of :username


  def is_valid_code?(code)
    verification_code == code
  end
  
end
