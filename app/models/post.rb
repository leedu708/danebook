class Post < ActiveRecord::Base

  belongs_to :poster, :class_name => 'User',
                      :foreign_key => :poster_id

  has_many :likes, :as => :liked, :dependent => :destroy
  has_many :likers, :through => :likes,
                    :source => :user

  has_many :comments, :as => :commentable,
                      :dependent => :destroy

  validates :body, :poster_id, :presence => :true
  validates :body, :length => { in: 1..300 }

  def self.get_newsfeed(friend_ids)

    Post.where('poster_id IN (?) AND created_at >= ?', friend_ids, 7.days.ago).
         order(:created_at => :desc).
         limit(10)

  end
  
end
