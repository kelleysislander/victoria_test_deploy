class CreateRedemptions < ActiveRecord::Migration
  def self.up
    create_table :redemptions do |t|
      t.integer :deal_id
      t.integer :num_redeemed
      t.integer :num_available
      t.timestamps
    end
  end

  def self.down
    drop_table :redemptions
  end
end

# rails g nifty:scaffold Redemption deal_id:integer num_redeemed:integer num_available:integer --haml

