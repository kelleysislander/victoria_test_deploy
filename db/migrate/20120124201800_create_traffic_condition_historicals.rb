class CreateTrafficConditionHistoricals < ActiveRecord::Migration
  def self.up
    create_table :traffic_condition_historicals do |t|
      t.integer :traffic_camera_id
      t.integer :traffic_rating_id
      t.integer :day_of_week
      t.string :time_of_day
      t.string :description
      t.timestamps
    end
    
    add_index :traffic_condition_historicals, :traffic_camera_id
    add_index :traffic_condition_historicals, :day_of_week
    add_index :traffic_condition_historicals, :time_of_day

  end

  def self.down
    drop_table :traffic_condition_historicals
  end
end

=begin
Billys-MacBook-Pro ~/Projects/victoria: rails g nifty:scaffold TrafficConditionHistorical traffic_camera_id:integer traffic_rating_id:integer day_of_week:integer time_of_day:string description:string --haml
      create  app/models/traffic_condition_historical.rb
      create  spec/models/traffic_condition_historical_spec.rb
      create  spec/fixtures/traffic_condition_historicals.yml
      create  db/migrate/20120124201800_create_traffic_condition_historicals.rb
      create  app/controllers/traffic_condition_historicals_controller.rb
      create  app/helpers/traffic_condition_historicals_helper.rb
      create  app/views/traffic_condition_historicals/index.html.haml
      create  app/views/traffic_condition_historicals/show.html.haml
      create  app/views/traffic_condition_historicals/new.html.haml
      create  app/views/traffic_condition_historicals/edit.html.haml
      create  app/views/traffic_condition_historicals/_form.html.haml
       route  resources :traffic_condition_historicals
      create  spec/controllers/traffic_condition_Historicals_controller_spec.rb
=end