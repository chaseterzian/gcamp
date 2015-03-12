require 'rails_helper'


feature 'User can create an account' do
  scenario 'User can not see tasks, users, or projects until account created - flash present ' do

    visit root_path
    expect(page).to have_link 'gCamp'
    expect(page).to have_link 'Sign In'
    expect(page).to have_link 'Sign Up'
    expect(page).to_not have_link 'Sign Out'

    within('.navbar') {click_link('Sign Up')}
    expect(current_path).to eq '/sign-up'

    expect(page).to have_content 'Sign up for gCamp!'
    expect(page).to have_content 'First Name'
    expect(page).to have_content 'Last Name'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
    expect(page).to have_content 'Password Confirmation'
    expect(page).to have_link 'Sign In'
    expect(page).to have_link 'About'
    expect(page).to have_link 'Terms'
    expect(page).to have_link 'FAQ'

    expect(page).to_not have_content 'Tasks'
    expect(page).to_not have_content 'Users'
    expect(page).to_not have_content 'Projects'

    click_button 'Sign Up'
    expect(page).to have_content "First name can't be blank"
    expect(page).to have_content "Last name can't be blank"
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"

    signup
    click_button 'Sign Up'
saveopen
    expect(current_path).to eq root_path
    expect(page).to have_content 'You have successfully signed up'

    expect(page).to have_link 'gCamp'
    expect(page).to have_link 'Michael Sprinklewood'
    expect(page).to have_link 'Sign Out'
    expect(page).to have_link 'Tasks'
    expect(page).to have_link 'Users'
    expect(page).to have_link 'Projects'

    expect(page).to_not have_link 'Sign Up'
    expect(page).to_not have_link 'Sign In'

  end
end
