class CreateRateResponses < ActiveRecord::Migration
  def change
    create_table :rate_responses do |t|
      t.text :response_data

      t.timestamps
    end
  end
end
