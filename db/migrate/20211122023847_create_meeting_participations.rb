# rubocop:disable Style/Documentation


class CreateMeetingParticipations < ActiveRecord::Migration[6.1]
  def change
    create_table :meeting_participations do |t|
      t.string :meeting_name
      t.integer :meeting_id
      t.integer :UIN

      t.timestamps
    end
    add_foreign_key :meeting_participations, :students, column: :UIN, primary_key: :UIN
  end
end
