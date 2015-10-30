class User < ActiveRecord::Base

  has_secure_password

  validates :password,
            :length => { :in => 5..24 },
            :allow_nil => false
            
end
