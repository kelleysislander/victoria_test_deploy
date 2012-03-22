class CreateDeviceRedemptions < ActiveRecord::Migration
  def self.up
    create_table :device_redemptions do |t|
      t.string  :device_uid
      t.integer :deal_id
      t.string  :redemption_type
      t.date    :redemption_date
      t.timestamps
    end
  end

  def self.down
    drop_table :device_redemptions
  end
end

=begin
Billys-MacBook-Pro ~/Projects/victoria: rails g nifty:scaffold DeviceRedemption device_uid:string deal_id:integer redemption_type:string redemption_date:date --haml
      create  app/models/device_redemption.rb
      create  spec/models/device_redemption_spec.rb
      create  spec/fixtures/device_redemptions.yml
      create  db/migrate/20120308205753_create_device_redemptions.rb
      create  app/controllers/device_redemptions_controller.rb
      create  app/helpers/device_redemptions_helper.rb
      create  app/views/device_redemptions/index.html.haml
      create  app/views/device_redemptions/show.html.haml
      create  app/views/device_redemptions/new.html.haml
      create  app/views/device_redemptions/edit.html.haml
      create  app/views/device_redemptions/_form.html.haml
       route  resources :device_redemptions
      create  spec/controllers/device_redemptions_controller_spec.rb

=end