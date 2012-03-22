class CreateRedemptionPassphrases < ActiveRecord::Migration
  def self.up
    create_table :redemption_passphrases do |t|
      t.string :passphrase
      t.date :beg_date
      t.date :end_date
      t.timestamps
    end
  end

  def self.down
    drop_table :redemption_passphrases
  end
end

=begin
Billys-MacBook-Pro ~/Projects/victoria: rails g nifty:scaffold RedemptionPassphrase passphrase:string beg_date:date end_date:date --haml
      create  app/models/redemption_passphrase.rb
      create  spec/models/redemption_passphrase_spec.rb
      create  spec/fixtures/redemption_passphrases.yml
      create  db/migrate/20120302180607_create_redemption_passphrases.rb
      create  app/controllers/redemption_passphrases_controller.rb
      create  app/helpers/redemption_passphrases_helper.rb
      create  app/views/redemption_passphrases/index.html.haml
      create  app/views/redemption_passphrases/show.html.haml
      create  app/views/redemption_passphrases/new.html.haml
      create  app/views/redemption_passphrases/edit.html.haml
      create  app/views/redemption_passphrases/_form.html.haml
       route  resources :redemption_passphrases
      create  spec/controllers/redemption_passphrases_controller_spec.rb

=end