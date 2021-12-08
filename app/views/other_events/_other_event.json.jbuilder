# frozen_string_literal: true

json.extract! other_event, :id, :event_id, :point_worth, :event_type, :number_participation, :created_at, :updated_at
json.url other_event_url(other_event, format: :json)
