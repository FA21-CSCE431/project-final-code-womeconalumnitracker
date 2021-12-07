class MeetingParticipation < ApplicationRecord
    belongs_to :student, foreign_key: :UIN
    validates :meeting_name, presence: true
    validates :UIN, presence: true
end
