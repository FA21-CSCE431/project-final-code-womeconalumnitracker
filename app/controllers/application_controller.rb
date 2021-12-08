# frozen_string_literal: true

# Applicaiton controller is used to check the status of a current user and promote to admin

# Class defines how to check if user is an admin
class ApplicationController < ActionController::Base
  before_action :authenticate_admin!

  helper_method :current_admin

  private

  def current_admin
    session[:email] || nil
  end
end
