# frozen_string_literal: true

json.extract! meeting, :id, :meeting_id, :meeting_name, :date, :location, :start_time, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
