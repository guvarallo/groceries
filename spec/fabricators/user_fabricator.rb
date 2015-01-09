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

Fabricator(:user) do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  password { 'password' }
end
