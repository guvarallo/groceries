# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  description :string
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  complete    :boolean          default("false"), not null
#

class Task < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :description

end
