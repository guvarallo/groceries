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

Fabricator(:task) do
  description { Faker::Lorem.sentence(3) }
end
