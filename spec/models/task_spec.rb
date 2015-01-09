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

require 'spec_helper'

describe Task do

  it { should belong_to(:user) }
  it { should validate_presence_of(:description) }

end
