# rubocop:disable Style/Documentation
#  frozen_string_literal: true

class CreateOtherEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :other_events do |t|
      t.integer :event_id
      t.integer :point_worth
      t.string :event_type
      t.integer :number_participation

      t.timestamps
    end
  end
end

# rubocop:enable
