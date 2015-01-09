require 'spec_helper'

feature 'Sign up' do

  scenario 'with valid input' do
    visit root_path
    click_link('Sign up with email')
    fill_in('Name',:with => 'Gus')
    fill_in('Email', :with => 'gus@example.com')
    fill_in('Password', :with => 'gus')
    fill_in('Password confirmation', :with => 'gus')
    click_button('Sign up')
    page.should have_content('Alright, sign up was successfully done, welcome Gus!')
  end

end
