class CreateTrafficCameras < ActiveRecord::Migration
  def self.up
    create_table :traffic_cameras do |t|
      t.string  :name
      t.string  :address
      t.decimal  :latitude,         :precision => 10, :scale => 6
      t.decimal  :longitude,        :precision => 10, :scale => 6
      t.string  :url
      t.integer :status
      t.integer :geocode_flag
      t.integer :compass_point_id
      t.timestamps
    end
  end

  def self.down
    drop_table :traffic_cameras
  end
end

=begin
Billys-MacBook-Pro ~/Projects/victoria: rails g nifty:scaffold TrafficCamera name:string address:string city:string latitude:float longitude:float status:integer --haml
      create  app/models/traffic_camera.rb
      create  spec/models/traffic_camera_spec.rb
      create  spec/fixtures/traffic_cameras.yml
      create  db/migrate/20111222195552_create_traffic_cameras.rb
      create  app/controllers/traffic_cameras_controller.rb
      create  app/helpers/traffic_cameras_helper.rb
      create  app/views/traffic_cameras/index.html.haml
      create  app/views/traffic_cameras/show.html.haml
      create  app/views/traffic_cameras/new.html.haml
      create  app/views/traffic_cameras/edit.html.haml
      create  app/views/traffic_cameras/_form.html.haml
       route  resources :traffic_cameras
      create  spec/controllers/traffic_cameras_controller_spec.rb

=end