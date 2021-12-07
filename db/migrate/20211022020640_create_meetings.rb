# rubocop:disable Style/Documentation


class CreateMeetings < ActiveRecord::Migration[6.1]
  def change
    create_table :meetings do |t|
      t.integer :meeting_id
      t.string :meeting_name
      t.date :date
      t.string :location
      t.timestamp :start_time

      t.timestamps
    end
  end
end

# rubocop:enable
