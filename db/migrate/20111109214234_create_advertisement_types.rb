class CreateAdvertisementTypes < ActiveRecord::Migration
  def change
    create_table :advertisement_types do |t|
      t.string :advertisement_type, :limit => 512
      t.string :description

      t.timestamps
    end
  end
end

# rails g scaffold AdvertisementType name:string description:string