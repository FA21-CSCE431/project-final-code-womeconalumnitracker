# frozen_string_literal: true

# OtherEvent model keeps track of parameters unique to an event

# Defines objects to be accessed by event controller
class OtherEvent < ApplicationRecord
  validates :event_id, presence: true, uniqueness: true
  validates :point_worth, presence: true
  validates :event_type, presence: true
  validates :number_participation, presence: true
end
