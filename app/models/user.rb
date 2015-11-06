class User < ActiveRecord::Base

  has_secure_password

  has_one :profile, :dependent => :destroy
  accepts_nested_attributes_for :profile

  has_many :posts, :foreign_key => :author_id, :dependent => :destroy

  has_many :likes, :foreign_key => :liker_id,
                   :dependent => :destroy
  has_many :liked_posts, :through => :likes,
                         :source => :post

  has_many :comments, :foreign_key => :author_id

  validates :email, :uniqueness => true, :format => { :with => /.+@.+/, :message => "enter a valid email." }
  # validates :password,
  #           :length => { :in => 5..24 },
  #           :allow_nil => false
  validates_confirmation_of :password

  before_create :generate_token

  def generate_token

    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])

  end

  def regenerate_auth_token

    self.auth_token = nil
    generate_token
    save!

  end
            
end
