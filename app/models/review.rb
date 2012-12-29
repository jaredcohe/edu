class Review < ActiveRecord::Base
  attr_accessible :body, :resource_id, :score, :title, :user_id  
  validates_presence_of :body, :resource_id, :score, :title, :user_id
  belongs_to :resource
end
