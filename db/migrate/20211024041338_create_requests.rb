# rubocop:disable Style/Documentation


class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.integer :UIN
      t.integer :event_id
      t.date :date_of_request
      t.integer :points_requested
      t.string :request_time
      t.boolean :approved
      t.timestamps
    end
    add_foreign_key :requests, :students, column: :UIN, primary_key: :UIN
  end
end

# rubocop:enable
