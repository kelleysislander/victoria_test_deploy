class AddImageToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :image, :string
  end
end

# rails g migration add_image_to_advertisements image:string