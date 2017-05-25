class FriendRequest < ActiveRecord::Base
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"

  belongs_to :receiver, :class_name => "User", :foreign_key => "receiver_id"

  validates :sender, :presence => true, :uniqueness => { :scope => :receiver }
  validates :receiver, :presence => true
end
