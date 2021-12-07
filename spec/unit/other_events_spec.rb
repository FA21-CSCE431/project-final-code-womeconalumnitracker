# frozen_string_literal: true

# rails spec ./spec/unit/other_events.rb
require 'rails_helper'

RSpec.describe OtherEvent, type: :model do
  before(:all) do
    @other_event = OtherEvent.create(event_id: 4, point_worth: 1, event_type: 'Nathan Custom Event',
                                     number_participation: 250)
  end

  it 'is valid with valid attributes' do
    expect(@other_event).to be_valid
  end

  it 'has no event_id' do
    @other_event.event_id = nil
    expect(@other_event).not_to be_valid
  end

  it 'has no last point_worth' do
    @other_event.point_worth = nil
    expect(@other_event).not_to be_valid
  end

  it 'has no event_type' do
    @other_event.event_type = nil
    expect(@other_event).not_to be_valid
  end

  it 'has no number_participation' do
    @other_event.number_participation = nil
    expect(@other_event).not_to be_valid
  end

  OtherEvent.delete(@other_event)
end
