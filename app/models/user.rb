class User < ActiveRecord::Base

  has_many :team_members

  attr_accessor :password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  nick_regex =  /\A[a-z][a-z0-9_-]{3,}\Z/i

  validates :name, :presence => true,
            :length => { :maximum => 50 }

  validates :nick_name, :presence => true,
            :uniqueness => true
            #:uniqueness => true,
            #:format => { :with => nick_regex }

  validates :email, :presence => true,
            :uniqueness => true,
            :format => { :with => email_regex }

  before_create :encrypt_password, :generate_token

  def has_password?(submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end

  def updateAppToken
    self.app_access_token = Digest::SHA2.hexdigest([Time.now, rand].join)
    self.save
  end

  def updatePassword(submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end

  #private

  def generate_token
    self.app_access_token = Digest::SHA2.hexdigest([Time.now, rand].join)
  end

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(self.password)
  end

  def encrypt(string)
    secure_hash("#{self.salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{self.password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

end
