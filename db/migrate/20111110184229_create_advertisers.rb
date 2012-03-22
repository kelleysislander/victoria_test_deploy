class CreateAdvertisers < ActiveRecord::Migration
  def change
    create_table :advertisers do |t|
      t.integer :advertiser_type_id,  :null => false
      t.integer :retailer_id
      t.string :name
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
end
