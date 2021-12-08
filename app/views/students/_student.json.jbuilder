# frozen_string_literal: true

json.extract! student, :id, :UIN, :first_name, :last_name, :meeting_points, :volunteer_points, :social_points,
              :total_points, :active_member, :created_at, :updated_at
json.url student_url(student, format: :json)
