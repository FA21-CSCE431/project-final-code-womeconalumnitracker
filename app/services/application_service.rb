# frozen_string_literal: true

# Service object to call methods inside of services

# Class to call methods
class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
