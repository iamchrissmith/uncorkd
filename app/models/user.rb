class User < ApplicationRecord
  has_secure_password

  def is_valid_code?(code)
    verification_code == code
  end
  
end
