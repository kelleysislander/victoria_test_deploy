class TrafficRating < ActiveRecord::Base

  attr_accessible :rating, :description, :icon_path

  has_many  :traffic_conditions
  has_many  :traffic_condition_historicals

  validates_presence_of :rating, :description, :icon_path

  validates_uniqueness_of :rating
  validates_uniqueness_of :description
  validates_uniqueness_of :icon_path

  validates_length_of :rating,      :within => 1..50,   :too_long => "Maximum size for 'Rating' is 50.",        :too_short => "Minimum size for 'Rating' is 1."
  validates_length_of :description, :within => 3..255,  :too_long => "Maximum size for 'Description' is 255.",  :too_short => "Minimum size for 'Description' is 3."
  validates_length_of :icon_path,   :within => 5..255,  :too_long => "Maximum size for 'Icon Path' is 255.",    :too_short => "Minimum size for 'Icon Path' is 5."
  
end
