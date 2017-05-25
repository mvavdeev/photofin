class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :photos, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  has_many :liked_photos, :through => :likes, :source => :photo

  has_many :friend_requests_where_sender, :class_name => "FriendRequest", :foreign_key => "sender_id", :dependent => :destroy
  has_many :friends_where_sender, :through => :friend_requests_where_sender, :source => :receiver

  has_many :friend_requests_where_receiver, :class_name => "FriendRequest", :foreign_key => "receiver_id", :dependent => :destroy
  has_many :friends_where_receiver, :through => :friend_requests_where_receiver, :source => :sender

  has_many :timeline_photos, :through => :friends_where_sender, :source => :photos

  validates :username, :presence => true, :uniqueness => true
end
