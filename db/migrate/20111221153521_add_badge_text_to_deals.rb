class AddBadgeTextToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :badge_text, :string
    add_column :deals, :badge_path, :string
  end
end
