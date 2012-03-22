class CreateAdvertiserTypes < ActiveRecord::Migration
  def change
    
    create_table :advertiser_types do |t|
      t.string :advertiser_type
      t.string :description
      t.timestamps
    end
    
  end
end
