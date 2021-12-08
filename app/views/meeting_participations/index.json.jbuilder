# frozen_string_literal: true

json.array! @meeting_participations, partial: 'meeting_participations/meeting_participation', as: :meeting_participation
