# == Schema Information
# Schema version: 20110428160452
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
  
  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
  
  default_scope :order => 'microposts.created_at DESC'
  
  scope :from_users_followed_by, lambda {|user| followed_by(user) }
  
  
  private
    
    # return a SQL condition for users followed by the given user
    # along with user's own id
    def self.followed_by(user)
      followed_ids = user.following.map(&:id).join(", ")
      where("user_id IN (#{followed_ids}) OR user_id = :user_id", 
            { :user_id => user })
    end
  
end
