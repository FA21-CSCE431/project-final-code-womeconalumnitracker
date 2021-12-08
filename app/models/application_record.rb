# frozen_string_literal: true

# This model is never instantiated as if only serves to solve single-table inheritance

# Class resembles a true interface object for all child classes
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
