# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base

  has_many :tasks

  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email

  has_secure_password
end
