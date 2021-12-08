# frozen_string_literal: true

json.extract! meeting_participation, :id, :meeting_id, :UIN, :created_at, :updated_at
json.url meeting_participation_url(meeting_participation, format: :json)
