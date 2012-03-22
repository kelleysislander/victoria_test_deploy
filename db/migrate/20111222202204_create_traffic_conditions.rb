class CreateTrafficConditions < ActiveRecord::Migration
  def self.up
    create_table  :traffic_conditions do |t|
      t.integer   :traffic_data_type_id
      t.integer   :traffic_camera_id
      t.integer   :traffic_rating_id
      t.integer   :compass_point_id
      t.timestamp :report_date
      t.string    :alert_message
      t.string    :other_source
      t.string    :other_description
      t.string    :other_address
      t.float     :other_latitude
      t.float     :other_longitude
      t.timestamps
    end
  end

  def self.down
    drop_table :traffic_conditions
  end
end
=begin
NOTE:  The "other_*" fields are used when an alert "other" than a camera is reported, as in twitter, email, eyewitness report, etc
the "other_source" would be something like "twitter", "other_descr" => "slow traffic eastbound car wreck" and the "other_address" would be for geocoding it,
and the latitide and longitude fields are self-explanatory as is the "report_datetime" field
=end
=begin
Billys-MacBook-Pro ~/Projects/victoria: rails g nifty:scaffold TrafficCondition traffic_camera_id:integer traffic_rating_id:integer traffic_direction_name:string traffic_direction_compass:integer status:integer --haml
      create  app/models/traffic_condition.rb
      create  spec/models/traffic_condition_spec.rb
      create  spec/fixtures/traffic_conditions.yml
      create  db/migrate/20111222202204_create_traffic_conditions.rb
      create  app/controllers/traffic_conditions_controller.rb
      create  app/helpers/traffic_conditions_helper.rb
      create  app/views/traffic_conditions/index.html.haml
      create  app/views/traffic_conditions/show.html.haml
      create  app/views/traffic_conditions/new.html.haml
      create  app/views/traffic_conditions/edit.html.haml
      create  app/views/traffic_conditions/_form.html.haml
       route  resources :traffic_conditions
      create  spec/controllers/traffic_conditions_controller_spec.rb
=end