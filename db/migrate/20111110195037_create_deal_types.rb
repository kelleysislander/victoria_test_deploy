class CreateDealTypes < ActiveRecord::Migration
  def change
    create_table :deal_types do |t|
      t.string :deal_type
      t.string :description

      t.timestamps
    end
  end
end
