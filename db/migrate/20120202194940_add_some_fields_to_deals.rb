class AddSomeFieldsToDeals < ActiveRecord::Migration
  def change
    add_column  :deals, :discount_percent_text,   :string
    add_column  :deals, :discount_amount_text,    :string
    add_column  :deals, :price_text,              :string
    add_column  :deals, :fine_print_text,         :string
    add_column  :deals, :deal_tag_text,           :string, :limit => 45
    add_column  :deals, :preview_flag,            :integer, :default => 1
    add_column  :deals, :active_flag,             :integer, :default => 0
    add_column  :deals, :retailer_latitude,       :float
    add_column  :deals, :retailer_longitude,      :float
    add_column  :deals, :share_to_unlock_pct,     :string
    add_column  :deals, :retailer_zone,           :integer
    add_column  :deals, :redemption_passphrase,   :string
    
  end
end

# rails g migration add_some_fields_to_deals discount_percent_text:string discount_amount_text:string price_text:string fine_print_text:string deal_tag:string