class User < ActiveRecord::Base

  has_many :tasks

  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email

  has_secure_password
end
