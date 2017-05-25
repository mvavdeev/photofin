class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  has_many :fans, :through => :likes, :source => :user

  validates :user, :presence => true
  validates :image, :presence => true

  mount_uploader :image, ImageUploader

  default_scope { order("created_at DESC") }
end
