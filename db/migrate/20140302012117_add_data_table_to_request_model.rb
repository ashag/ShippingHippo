class AddDataTableToRequestModel < ActiveRecord::Migration
  def change
    create_table :rate_requests do |t|
      t.text :request_data

      t.timestamps

    end
  end
end
