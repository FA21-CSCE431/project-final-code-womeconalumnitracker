# rubocop:disable Style/Documentation


class CreateMeetingParticipations < ActiveRecord::Migration[6.1]
  def change
    create_table :meeting_participations do |t|
      t.integer :meeting_id
      t.string :UIN

      t.timestamps
    end
  end
end
