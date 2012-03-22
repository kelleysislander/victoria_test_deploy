class AddRetailerCategoryIdToRetailers < ActiveRecord::Migration
  def change
    add_column :retailers, :retailer_category_id, :integer
  end
end

# rails generate migration AddRetailerCategoryIdToRetailers retailer_category_id:integer