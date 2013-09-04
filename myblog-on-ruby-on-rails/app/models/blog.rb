class Blog < ActiveRecord::Base
  attr_accessible :description, :title
  has_many :posts, :dependent => :destroy
  belongs_to :user
  validates :title, :presence => true, :length => { :maximum =>150 }
  validates :description, :presence => true
end
