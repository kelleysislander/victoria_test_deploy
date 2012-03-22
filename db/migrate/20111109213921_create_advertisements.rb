class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.integer   :advertisement_type_id
      t.integer   :retailer_id
      t.integer   :advertiser_id
      t.string    :name
      t.string    :description, :limit => 3000
      t.text      :content
      t.string    :retailer_zone
      t.string    :url
      t.datetime  :beg_date
      t.datetime  :end_date
      t.timestamps
    end
  end
end

# rails g scaffold Advertisement name:string description:string content:text beg_date:datetime end_date:datetime