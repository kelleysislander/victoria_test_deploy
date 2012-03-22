class AddImageToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :image, :string
    add_column :deals, :featured_image, :string
  end
end

# rails g migration add_image_to_deals image:string