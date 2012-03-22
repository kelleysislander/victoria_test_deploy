class CreateTrafficDataTypes < ActiveRecord::Migration
  def self.up
    create_table :traffic_data_types do |t|
      t.string :name
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :traffic_data_types
  end
end

# rails g nifty:scaffold TrafficDataType name:string description:string --haml