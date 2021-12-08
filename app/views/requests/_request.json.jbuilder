# frozen_string_literal: true

json.extract! request, :id, :event_id, :UIN, :date_of_request, :points_requested, :request_time, :approved, :id,
              :created_at, :updated_at
json.url request_url(request, format: :json)
