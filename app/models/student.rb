# frozen_string_literal: true

# Model for accessing objects of a student

# Contain all information unique to a student user
class Student < ApplicationRecord
    attribute :volunteer_points, :integer, default: 0
    attribute :social_points, :integer, default: 0
    attribute :meeting_points, :integer, default: 0
    attribute :paid_dues, :boolean, default: false
    attribute :active_member, :boolean, default: false
    has_many :requests, dependent: :destroy, foreign_key: :UIN
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :UIN, presence: true
    validates :meeting_name, presence: true
end
