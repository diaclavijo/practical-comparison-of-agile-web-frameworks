class Comment < ActiveRecord::Base
  attr_accessible :body, :email, :author, :website
  belongs_to :post
  belongs_to :user
  before_save { |comment| comment.email = email.downcase }
  validates :author, :presence => true, :length => { :maximum =>50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :format  =>  { :with => VALID_EMAIL_REGEX }
  validates :body, :presence => true, :length => { :maximum =>500 }
end
