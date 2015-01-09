require 'spec_helper'

feature 'user task' do

  scenario 'with valid input' do
    sign_in

    visit tasks_path
    click_link('New Task')

    fill_in('Description', :with => "Test task")
    click_button('Add')

    page.should have_content("Test task")
  end

end
