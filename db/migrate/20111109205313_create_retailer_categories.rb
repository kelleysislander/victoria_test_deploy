class CreateRetailerCategories < ActiveRecord::Migration
  def change
    create_table :retailer_categories do |t|
      t.string :retailer_category
      t.string :description

      t.timestamps
    end
  end
end

# rails g model RetailerCategory name:string description:string
# rails g scaffold RetailerCategory name:string description:string