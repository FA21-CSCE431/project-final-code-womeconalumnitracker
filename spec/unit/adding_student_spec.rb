# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  before(:all) do
    @student = Student.create!(UIN: '111000111', first_name: 'Nathan', last_name: 'Reddy', meeting_points: 0,
                               volunteer_points: 0, social_points: 0, total_points: 0)
  end

  it 'is valid with valid attributes' do
    expect(@student).to be_valid
  end

  it 'has no first name' do
    @student.first_name = nil
    expect(@student).not_to be_valid
  end

  it 'has no last name' do
    @student.last_name = nil
    expect(@student).not_to be_valid
  end

  it 'has no UIN' do
    @student.UIN = nil
    expect(@student).not_to be_valid
  end
end
