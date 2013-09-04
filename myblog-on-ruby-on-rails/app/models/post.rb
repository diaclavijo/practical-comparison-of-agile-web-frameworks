class Post < ActiveRecord::Base
  attr_accessible :body, :title
  belongs_to :blog
  has_many :comments, :dependent => :destroy
  validates :title, :presence => true, :length => { :maximum =>150 }
  before_save do |post|
    post.permalink = post.title.parameterize
  end
  def self.search(search)
    if search
      search = '%'+search+'%'
      where('(title LIKE ?) OR (body LIKE ?)', search, search)
    else
      find(:all)
    end
  end
  def to_param
    self.permalink
  end
end
