class AddTypeToRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :requests, :request_type, :string
  end
end
