class CreateTrafficRatings < ActiveRecord::Migration
  def self.up
    create_table :traffic_ratings do |t|
      t.string :rating
      t.string :desscription
      t.string :icon_path
      t.timestamps
    end
  end

  def self.down
    drop_table :traffic_ratings
  end
end

=begin
Billys-MacBook-Pro ~/Projects/victoria: rails g nifty:scaffold TrafficRating rating:string dsescription:string icon_path:string --haml
      create  app/models/traffic_rating.rb
      create  spec/models/traffic_rating_spec.rb
      create  spec/fixtures/traffic_ratings.yml
      create  db/migrate/20111222203314_create_traffic_ratings.rb
      create  app/controllers/traffic_ratings_controller.rb
      create  app/helpers/traffic_ratings_helper.rb
      create  app/views/traffic_ratings/index.html.haml
      create  app/views/traffic_ratings/show.html.haml
      create  app/views/traffic_ratings/new.html.haml
      create  app/views/traffic_ratings/edit.html.haml
      create  app/views/traffic_ratings/_form.html.haml
       route  resources :traffic_ratings
      create  spec/controllers/traffic_ratings_controller_spec.rb
=end