class CreateDeals < ActiveRecord::Migration
  def self.up
    create_table :deals do |t|
      t.integer   :deal_type_id
      t.integer   :retailer_id
      t.integer   :advertiser_id
      t.string    :name
      t.string    :description, :limit => 3000
      t.text      :content
      t.integer   :featured_flag
      t.integer   :num_offered
      t.integer   :num_available
      t.integer   :num_redeemed, :default => 0
      t.date      :beg_date
      t.date      :end_date
      t.integer   :skeleton_flag, :default => 1
      t.string    :gender, :limit => 1, :default => "B"
      t.integer   :social_discount_interval
      t.timestamps
    end
  end
  
  def self.down
    drop_table :deals
  end
end

=begin
NOTE: gender is used to identify the target gender of the deal.  Possible values are (M)ale, (F)emale,, or (B)oth 
NOTE: skeleton_flag is used to indicate that the record is a template, or a skeleton of the "real" record that was set up by the miinfo user and not the end user
The admin creates a skeleton record and the end user completes it.

Skeleton required items:

name
advertiser_id ???
retailer_id
beg_date
end_date

The admin can create a record with just these attributes and then the "retailer" user can complete the other fields and edit the name.  The retailer_id select options
are pre-filled with just the retailers that belong to the account that the retailer end user belongs to.
=end