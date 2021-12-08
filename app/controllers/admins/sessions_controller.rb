# frozen_string_literal: true

# Controller service to cache the current user session for access control

module Admins
  # Class definition what session to assign an admin
  class SessionsController < Devise::SessionsController
    def after_sign_out_path_for(_resource_or_scope)
      new_admin_session_path
    end

    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || root_path
    end
  end
end
