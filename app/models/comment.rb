class Comment < ActiveRecord::Base

  belongs_to :commentable, :polymorphic => true

  has_many :likes, :as => :liked,
                   :dependent => :destroy
  has_many :likers, :through => :likes,
                    :source => :user
                    
  belongs_to :author, :class_name => 'User',
                      :foreign_key => :author_id

  validates :body, :presence => true, :length => { in: 1..140 }
                      
end
