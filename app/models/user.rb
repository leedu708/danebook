class User < ActiveRecord::Base

  has_secure_password

  has_one :profile, :dependent => :destroy
  accepts_nested_attributes_for :profile

  validates :password,
            :length => { :in => 5..24 },
            :allow_nil => false
            
end
