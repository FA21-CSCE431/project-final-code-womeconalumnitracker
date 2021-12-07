class DropEventIdFromOtherEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :other_events, :event_id
  end
end
