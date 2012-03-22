class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.string :description
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :contact_name
      t.string :contact_email
      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end

# rails g nifty:scaffold Account name:string description:string address:string city:string state:string zip:string phone:string contact_name:string contact_email:string