

require 'rails_helper'

RSpec.describe 'Student', type: :feature do
  scenario 'Adding student' do
    visit students_url
    login
    click_on 'New Student'
    # puts page.html
    fill_in 'student_UIN', with: '111000111'
    fill_in 'student_first_name', with: 'Nathan'
    fill_in 'student_last_name', with: 'Reddy'
    fill_in 'student_meeting_points', with: '0'
    fill_in 'student_volunteer_points', with: '0'
    fill_in 'student_social_points', with: '0'
    fill_in 'student_total_points', with: '0'
    click_on 'Create Student'
    click_on 'Back'
    # puts page.html
    expect(page).to have_content('Reddy')
    Rails.application.env_config['omniauth.auth'] = nil
    OmniAuth.config.mock_auth[:google] = nil
  end

  scenario 'Removing student' do
    visit students_url
    login
    @student = Student.create!(UIN: '111000111', first_name: 'Nima', last_name: 'Ghadiri', meeting_points: 0,
                               volunteer_points: 0, social_points: 0, total_points: 0)
    visit students_url
    expect(page).to have_content('Ghadiri')
    click_on 'Destroy'
    expect(page).not_to have_content('Ghadiri')
    Rails.application.env_config['omniauth.auth'] = nil
    OmniAuth.config.mock_auth[:google] = nil
  end

  scenario 'Editing student' do
    visit students_url
    login
    @student = Student.create!(UIN: '111000111', first_name: 'Nima', last_name: 'Ghadiri', meeting_points: 0,
                               volunteer_points: 0, social_points: 0, total_points: 0)
    visit students_url
    expect(page).to have_content('Ghadiri')
    expect(page).not_to have_content('Reddy')
    click_on 'Edit'
    fill_in 'student_last_name', with: 'Reddy'
    click_on 'Update Student'
    click_on 'Back'
    expect(page).to have_content('Reddy')
    Rails.application.env_config['omniauth.auth'] = nil
    OmniAuth.config.mock_auth[:google] = nil
  end
end
