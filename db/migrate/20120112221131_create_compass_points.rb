class CreateCompassPoints < ActiveRecord::Migration
  def change
    create_table :compass_points do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
