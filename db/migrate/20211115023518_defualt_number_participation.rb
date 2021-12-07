class DefualtNumberParticipation < ActiveRecord::Migration[6.1]
    def change
      change_column :other_events, :number_participation, :integer, default: "0"
    end
  end
