class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :website, :avatar
  attr_accessor :check_password
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  has_one :blog, :dependent => :destroy
  has_many :comments, :dependent => :nullify
  has_secure_password
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  validates :name, :presence => true, :length => { :maximum =>50 }, :uniqueness => { :case_sensitive => false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,
                    :format  =>  { :with => VALID_EMAIL_REGEX },
                    :uniqueness => { :case_sensitive => false }
  validates :password, :presence => true,
                        :length => { :minimum => 6 } ,
                        :confirmation => true, :if => :check_password
  private
    def create_remember_token
      self.remember_token = SecureRandom.base64.tr("+/", "-_")
    end
end
