class CreateRetailers < ActiveRecord::Migration
  def self.up
    create_table :retailers do |t|
      t.integer :account_id,      :null => false
      t.string  :name,           :null => false
      t.string  :address,        :null => false
      t.string  :city
      t.string  :state
      t.string  :zip
      t.string  :phone
      t.string  :contact_name,   :null => false
      t.string  :contact_email,  :null => false
      t.string  :url
      t.timestamps
    end
  end
  
  def self.down
    drop_table :retailers
  end
end

=begin
ALTER TABLE retailers CHANGE COLUMN city city VARCHAR(255) NULL, CHANGE COLUMN state state VARCHAR(255) NULL, CHANGE COLUMN zip zip VARCHAR(255) NULL;
=end