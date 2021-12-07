class AddNameToOtherEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :other_events, :name, :string
  end
end
