# frozen_string_literal: true

# OtherEvent model keeps track of parameters unique to an event

# Defines objects to be accessed by event controller
class OtherEvent < ApplicationRecord
    validates :event_type, presence: true
    validates :number_participation, presence: true
    validates :name, presence: true, uniqueness: true
end
