class MeetingParticipation < ApplicationRecord
    validates :meeting_id, presence: true
    validates :UIN, presence: true
end