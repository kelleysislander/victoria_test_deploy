class AddAccountIdToSomeTables < ActiveRecord::Migration
  def change
    
    # Users
    change_table :users do |t|
      t.integer :account_id
    end


    # Retailers
    # change_table :retailers do |t|
    #   t.integer :account_id
    # end
        
  end
end
