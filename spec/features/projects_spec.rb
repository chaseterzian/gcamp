require 'rails_helper'


feature 'User can Create, Read, Update and Delete Projects with flash messages.' do

  scenario 'Test Projects-Index page links, redirects, content and funtionality' do

    create_user
    visit signin_path
    login
    click_button 'Sign In'
    expect(current_path).to eq projects_path

    expect(page).to have_link 'gCamp'
    expect(page).to have_link 'Chase Gnar'
    expect(page).to have_link 'Sign Out'
    expect(page).to_not have_link 'Sign In'
    expect(page).to_not have_link 'Sign Up'

    within("footer") do
      expect(page).to have_link 'About'
      expect(page).to have_link 'Terms'
      expect(page).to have_link 'FAQ'
      expect(page).to have_link 'Home'
    end

    expect(page).to have_content 'Projects'
    expect(page).to have_content 'Name'
    expect(page).to have_content 'Tasks'
  end

  scenario 'Test New-Project page for content, links, flash message, redirects and functionality' do

    create_user
    visit signin_path
    login
    click_button 'Sign In'
    click_link 'Projects'
    visit new_project_path
    within('.navbar') do
      click_link 'New Project'
    end
    expect(current_path).to eq (new_project_path)
    visit new_project_path

    expect(page).to have_link 'gCamp'
    expect(page).to have_link 'Chase Gnar'
    expect(page).to have_link 'Sign Out'
    expect(page).to_not have_link 'Sign In'
    expect(page).to_not have_link 'Sign Up'

    within("footer") do
      expect(page).to have_link 'About'
      expect(page).to have_link 'Terms'
      expect(page).to have_link 'FAQ'
      expect(page).to have_link 'Home'
    end

    within(".breadcrumb") do
      expect(page).to have_link 'Projects'
      expect(page).to have_content 'New Project'
    end

    expect(page).to have_content 'New Project'
    expect(page).to have_content 'Name'
    expect(find_link('Cancel')[:href]).to eq(projects_path)
    click_button 'Create Project'

    expect(page).to have_content '1 error prohibited this form from being saved'
    expect(page).to have_content "can't be blank"

    fill_in 'Name', with: 'Test Project'
    click_button 'Create Project'

    expect(current_path).to eq (project_tasks_path(Project.last))

  end

  scenario 'Test Show-Project page content, links, flash message, redirects and functionality' do

    create_user
    visit signin_path
    login
    click_button 'Sign In'
    click_link 'Projects'
    within('.navbar') do
      click_link 'New Project'
    end
    fill_in 'Name', with: 'Test Project'
    click_button 'Create Project'
    expect(current_path).to eq (project_tasks_path(Project.last))

    within(".breadcrumb") do
      expect(page).to have_link 'Projects'
      click_link 'Test Project'
    end

    expect(page).to have_link 'gCamp'
    expect(page).to have_link 'Chase Gnar'
    expect(page).to have_link 'Sign Out'
    expect(page).to_not have_link 'Sign In'
    expect(page).to_not have_link 'Sign Up'

    within("footer") do
      expect(page).to have_link 'About'
      expect(page).to have_link 'Terms'
      expect(page).to have_link 'FAQ'
      expect(page).to have_link 'Home'
    end

    click_link 'Edit'
    expect(current_path).to eq (edit_project_path(Project.last))

  end

  scenario 'Test Edit-Page content, links, flash message, redirects and functionality' do

    create_user
    visit signin_path
    login
    click_button 'Sign In'
    click_link 'Projects'
    within('.navbar') do
      click_link 'New Project'
    end
    fill_in 'Name', with: 'Test Project'
    click_button 'Create Project'
    within(".breadcrumb") do
      click_link 'Test Project'
    end
    click_link 'Edit'
    expect(current_path).to eq (edit_project_path(Project.last))

    expect(page).to have_link 'gCamp'
    expect(page).to have_link 'Chase Gnar'
    expect(page).to have_link 'Sign Out'
    expect(page).to_not have_link 'Sign In'
    expect(page).to_not have_link 'Sign Up'

    within("footer") do
      expect(page).to have_link 'About'
      expect(page).to have_link 'Terms'
      expect(page).to have_link 'FAQ'
      expect(page).to have_link 'Home'
    end

    within(".breadcrumb") do
      expect(page).to have_link 'Projects'
      expect(page).to have_link 'Test Project'
      expect(page).to have_content 'Edit'
    end

    expect(page).to have_content 'Edit Project'
    expect(page).to have_content 'Name'
    expect(find_link('Cancel')[:href]).to eq(projects_path)

    fill_in 'Name', with: ' '
    click_button 'Update Project'
    expect(page).to have_content '1 error prohibited this form from being saved'
    expect(page).to have_content "can't be blank"

    fill_in 'Name', with: 'Test Project Edited'
    click_button 'Update Project'
    expect(current_path).to eq (project_path(Project.last))
    expect(page).to have_content 'Project was successfully updated'
    expect(page).to have_content 'Test Project Edited'

  end

  scenario 'Test delete project and existing project functons and flash messages' do

    create_user
    create_project
    visit signin_path
    login
    click_button 'Sign In'
    click_link 'Projects'
    within('.navbar') do
      click_link 'New Project'
    end
    fill_in 'Name', with: 'Test Project'
    click_button 'Create Project'
    within(".breadcrumb") do
      click_link 'Test Project'
    end
    expect(current_path).to eq (project_path(Project.last))

    within(".well") do
      click_link 'Delete'
    end

    expect(current_path).to eq (projects_path)
    expect(page).to have_content 'Project was successfully deleted'
  end

end
