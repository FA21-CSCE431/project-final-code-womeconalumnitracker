# frozen_string_literal: true

# Model for accessing objects of a student

# Contain all information unique to a student user
class Student < ApplicationRecord
  has_many :requests, foreign_key: :UIN
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :UIN, presence: true
end
