class CreateMobileUserEvents < ActiveRecord::Migration
  def self.up
    create_table :mobile_user_events do |t|
      t.string :device_uid
      t.string :user_event
      t.string :description
      t.datetime :user_event_date
      t.timestamps
    end
  end

  def self.down
    drop_table :mobile_user_events
  end
end
