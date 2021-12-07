# rails spec ./spec/unit/adding_meeting_participation.rb
require 'rails_helper'

RSpec.describe MeetingParticipation, type: :model do
  before(:all) do
    @meeting_participation = MeetingParticipation.create(meeting_id: 1, UIN: "12345")
  end

  it 'is valid with valid attributes' do
    expect(@meeting_participation).to be_valid
  end

  it 'has no meeting_id' do
    @meeting_participation.meeting_id = nil
    expect(@meeting_participation).not_to be_valid
  end

  it 'has no UIN' do
    @meeting_participation.UIN = nil
    expect(@meeting_participation).not_to be_valid
  end

  MeetingParticipation.delete(@meeting_participation)
end