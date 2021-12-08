# rspec ./spec/feature/meeting_participation_integration_spec.rb

require 'rails_helper'

def login
  Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
  visit students_url
  click_link 'Sign in with Google'
end

RSpec.describe 'Meeting Participation', type: :feature do

  scenario 'deleting meeting participation' do
    login()
    visit meeting_participations_url
    click_on 'New Meeting Participation'

    fill_in 'meeting_participation_meeting_id', with: 1
    fill_in 'meeting_participation_UIN', with: '12345'
    click_on 'Create Meeting participation'
    click_on 'Back'
    #puts page.html
    expect(page).to have_content('12345')
    click_on 'Destroy'
    expect(page).not_to have_content('12345')
    Rails.application.env_config["omniauth.auth"] = nil
    OmniAuth.config.mock_auth[:google] = nil
  end

  scenario 'adding/filtering meeting participation' do
    login()
    visit meeting_participations_url
    click_on 'New Meeting Participation'

    fill_in 'meeting_participation_meeting_id', with: 1
    fill_in 'meeting_participation_UIN', with: '12345'
    click_on 'Create Meeting participation'
    click_on 'Back'
    #puts page.html
    expect(page).to have_content('12345')
    fill_in 'id', with: 1
    expect(page).to have_content('12345')
    Rails.application.env_config["omniauth.auth"] = nil
    OmniAuth.config.mock_auth[:google] = nil
  end

end