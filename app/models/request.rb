# frozen_string_literal: true

# Requests model holds the student requests that are pending

# Model contains information needed to identify a student
class Request < ApplicationRecord
  belongs_to :student, foreign_key: :UIN
  before_create do 
    self.date_of_request = Date.today
  end
end
