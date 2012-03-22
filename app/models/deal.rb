class Deal < ActiveRecord::Base
  
  require 'validations' # explicitly loaded here because it is only needed here 
  
  # NOTE: we really don't geocode deals at all, but this is here so that we can use the "Deal.near()" method that geocoder provides.  
  # When the deal is first created the latitude and longitude from the retailer is written to these two columns by a couple of hidden fields "retailer_latitude" & "retailer_longitude"
  # in the deals form
  geocoded_by :content, :latitude  => :retailer_latitude, :longitude => :retailer_longitude
  
  paginates_per 8 # kaminari pagination
  
  mount_uploader :image,          DealImageUploader         # the square main deal image shown on the deal details "show" page
  mount_uploader :featured_image, FeaturedDealImageUploader # the rectangular featured deal image graphic
  
  auto_strip  :name, :description, :content, :num_offered, :num_available, :num_redeemed, :deal_tag_text, :discount_percent_text, :discount_amount_text, :price_text, :fine_print_text, :skeleton_flag
  
  # slash_strip :badge_text
  
  # belongs_to  :deal_type
  belongs_to  :retailer
  belongs_to  :advertiser
  
  has_many    :redemptions
  has_many    :device_redemptions
  has_many    :advertisements,  :through => :retailers
  has_one     :account,         :through => :retailers 
  
  # required if "skeleton_flag == 1"
  validates_presence_of [ :featured_flag, 
                          :name, 
                          :retailer_id, 
                          :advertiser_id, 
                          # :deal_type_id, 
                          :beg_date, 
                          :end_date], :if => lambda{ |obj| obj.skeleton_flag == 1 }
  # required if "skeleton_flag" == 0
  validates_presence_of [ :featured_flag, 
                          :name, :retailer_id, 
                          :advertiser_id, 
                          # :deal_type_id, 
                          :beg_date, 
                          :end_date, 
                          :gender,
                          :active_flag,
                          :image,
                          :description, 
                          :num_offered, 
                          # :badge_text, 
                          :discount_percent_text, 
                          :discount_amount_text, 
                          :price_text, 
                          :fine_print_text,
                          :share_to_unlock_pct,
                          :deal_tag_text, 
                          :preview_flag,
                          :social_discount_interval,
                          :redemption_passphrase ], :if => lambda{ |obj| obj.skeleton_flag == 0 }
                          
  validates_presence_of :featured_image, :if => lambda{ |obj| obj.featured_flag == 1 && obj.skeleton_flag == 0 }  
  validates_length_of :name,                  :within => 5..255,  :too_long => "Maximum size for 'Name' is 255",          :too_short => "Minimum size for 'Name' is 5"
  validates_length_of :description,           :within => 5..255,  :too_long => "Maximum size for 'Description' is 255",   :too_short => "Minimum size for 'Description' is 5", :if => lambda{ |obj| obj.skeleton_flag == 0 }    
  validates_length_of :redemption_passphrase, :within => 5..255,  :too_long => "Maximum size for 'Redemption Passphrase' is 255",   :too_short => "Minimum size for 'Redemption Passphrase' is 5", :if => lambda{ |obj| obj.skeleton_flag == 0 }    
  # validates_length_of :badge_text,            :within => 3..8,    :too_long => "Maximum size for 'Badge Text' is 8",      :too_short => "Minimum size for 'Badge Text' is 3", 
  #   :if => lambda{ |obj| obj.skeleton_flag == 0 }
  

  validates_length_of :discount_percent_text, :in => 2..3,        :message => "Discount Percent Text must be 2 or 3 chars in length (ie. '50%')", :if => lambda{ |obj| obj.skeleton_flag == 0 }    
  validates_length_of :discount_amount_text,  :within => 2..6,    :too_long => "Maximum size for 'Discount Amount Text' is 2 (ie, '$2')", :too_short => "Minimum size for 'Discount Amount Text is' is 5 (ie, '$2000')"  , 
    :if => lambda{ |obj| obj.skeleton_flag == 0 }
  validates_length_of :price_text,            :within => 2..8,    :too_long => "Maximum size for 'Price Text' is 2 (ie, '$2')", :too_short => "Minimum size for 'Price Text is' is 8 (ie, '$1999.95')"  , 
    :if => lambda{ |obj| obj.skeleton_flag == 0 } 
  validates_length_of :deal_tag_text,         :within => 9..12,   :too_long => "Maximum size for 'Deal Tag Text' is 15 (ie, 'Get It $1999.95')", :too_short => "Minimum size for 'Deal Tag Text' is 8 (ie, 'Get It $9')"  , 
    :if => lambda{ |obj| obj.skeleton_flag == 0 }
  validates_length_of :fine_print_text,       :maximum => 60,     :message  => "Maximum size for 'Fine Print Text' is 60" 
  validates_length_of :share_to_unlock_pct, :in => 3..4,          :message => "Share to Unlock Percent must be 3 or 4 chars in length (ie. '+15%')", :if => lambda{ |obj| obj.skeleton_flag == 0 }    
                                                                                                                                                                        
  validates_numericality_of   :num_offered,               :if => lambda{ |obj| obj.skeleton_flag == 0 }
  validates_positive_or_zero  :num_offered,               :if => lambda{ |obj| obj.skeleton_flag == 0 }
  validates_numericality_of   :social_discount_interval,  :if => lambda{ |obj| obj.skeleton_flag == 0 }

  validates :beg_date, :date => {:before_or_equal_to => :end_date }, :if => lambda{ |obj| obj.end_date != nil } # gem date_validator
  
  # validate :calc_deals_num_attributes #, :on => :create
  # after_validation :calc_deals_num_available #, :on => :create

  scope :active,              lambda{ where('CURDATE() >= beg_date AND CURDATE() <= end_date AND active_flag = 1' ) }
  scope :featured,            lambda{ { :conditions => ['deals.featured_flag = 1'] } }
  scope :isapreview,          lambda{ { :conditions => ['deals.preview_flag = 1'] } }
  scope :nonfeatured,         lambda{ { :conditions => ['deals.featured_flag = 0'] } }
  scope :notapreview,         lambda{ { :conditions => ['deals.preview_flag = 0'] } }
  scope :active_featured,     lambda { active.featured }
  scope :active_nonfeatured,  lambda { active.nonfeatured }
  scope :in_zone,             lambda{ { :conditions => ['deals.preview_flag = 0'] } }
  
  before_save :set_num_available,     :on => :create # only set this attribute when the new record is first created
  validate :calc_new_num_available,   :on => :update, :if => lambda{ |obj| obj.num_offered_changed? }
  
  Flags = [
    # Displayed     stored in DB
    [ "No",             0     ],
    [ "Yes",            1     ]
  ]

  Genders = [
    # Displayed     stored in DB
    [ "Male",           "M"     ],
    [ "Female",         "F"     ],
    [ "Both",           "B"     ]
  ]

  #  Example usage:
  #  num = 138.249
  #  round_to(num, 2) => 138.25
  def self.round_to(num, precision)
    (num * 10**precision).round.to_f / 10**precision
  end

  def self.get_all_deals( current_coords )
    zone = Map.which_zone?( current_coords )
    # get ALL featured deals
    featureds = Deal.active.featured.includes(:retailer).near( current_coords, Victoria::Application::RadiusDistance, { :units => :km }).order('rand()') 
    featureds_ids = featureds.map(&:id)
    # get all nonfeatured deals in the  user's zone that have not already been selected
    zones = Deal.active.nonfeatured.includes(:retailer).near( current_coords, Victoria::Application::RadiusDistance, { :units => :km }).where([ "retailer_zone = ? AND id NOT IN (?)", zone, featureds_ids ]).order('rand()') 
    zones_ids = zones.map(&:id)
    # get all nonfeatured deals NOT IN the user's zone that have not already been selected as featureds OR zones
    regulars = Deal.active.nonfeatured.includes(:retailer).near( current_coords, Victoria::Application::RadiusDistance, { :units => :km }).where( [ "retailer_zone NOT IN (?) AND id NOT IN (?) AND id NOT IN (?)", zone, featureds_ids, zones_ids ] ).order('rand()')
    regulars_ids = regulars.map(&:id)
    # Add all 3 resultsets together
    featureds + zones + regulars
  end
  
=begin
  NOTE: called from console this way:
  api = ApiController.new
  api.deals_with_ads( nil ) # nil defaults to Victoria::Application::GT_Coords
  
  Deal.deals_with_ads( current_coords ||= Victoria::Application::GT_Coords )
  
  Deal.active.near( [14.643109, -90.522800], 3, { :units => :km }).length
  distance = 1
  deals = Deal.active.near( [14.643109, -90.522800], distance, { :units => :km })
  puts "Count: ********* #{deals.length}"
  deals.each do |deal|
    puts "#{deal.retailer.name}, #{deal.name}"
  end
  current_coords = Victoria::Application::GT_Coords
  n_deals = Deal.active.near( current_coords, Victoria::Application::RadiusDistance, { :units => :km }).length
=end
  def self.deals_with_ads( current_coords ) # set to Guatemala City coords if current_coords is nil current_coords = Victoria::Application::GT_Coords (an array of [lat, lng])
    n_deals           = Deal.active.near( current_coords, Victoria::Application::RadiusDistance, { :units => :km }).length
    n_ads             = Advertisement.active.length
    ad_to_deal_ratio  = 0.2 # ie. 20%
    n_ads_to_select   = ( n_deals * ad_to_deal_ratio ).ceil
    ad_modulo         = ( n_deals / n_ads_to_select )
    # get ALL "Featured Sponsored" Ads in random order
    featured_ads  = Advertisement.active.featured.order('rand()') 
    regular_ads   = Advertisement.active.regular.order('rand()')
    all_ads = featured_ads + regular_ads
    # get ALL "Regular Sponsored" Ads in random order
    
    # Now get the 3 randomly ordered resultsets for "Featured", "Zone", and "Regular" deals
=begin
  NOTE:
  This leads us to a solution to quickly getting random rows through ActiveRecord:

  def random(scope, num_randoms)
    count = scope.count
    unique_randoms(num_randoms, count){|i| scope.first :offset => i}
  end

  The above solution is appropriate for large result sets where :order => 'RAND()' is inefficient, and for small quantities of random rows. Each random row adds a query to this solution.
=end    
    # zone = Map.which_zone?( current_coords )
    # # get ALL featured deals
    # featureds = Deal.active.featured.includes(:retailer).near( current_coords, Victoria::Application::RadiusDistance, { :units => :km }).order('rand()') 
    # featureds_ids = featureds.map(&:id)
    # # get all nonfeatured deals in the  user's zone that have not already been selected
    # zones = Deal.active.nonfeatured.includes(:retailer).near( current_coords, Victoria::Application::RadiusDistance, { :units => :km }).where([ "retailer_zone = ? AND id NOT IN (?)", zone, featureds_ids ]).order('rand()') 
    # zones_ids = zones.map(&:id)
    # # get all nonfeatured deals NOT IN the user's zone that have not already been selected as featureds OR zones
    # regulars = Deal.active.nonfeatured.includes(:retailer).near( current_coords, Victoria::Application::RadiusDistance, { :units => :km }).where( [ "retailer_zone NOT IN (?) AND id NOT IN (?) AND id NOT IN (?)", zone, featureds_ids, zones_ids ] ).order('rand()')
    # regulars_ids = regulars.map(&:id)
    # # Add all 3 resultsets together
    # all_deals = featureds + zones + regulars
    all_deals = self.get_all_deals( current_coords )
    # intersperse the Advertisements from "all_ads" every "ad_modulo" records remembering that after each insertion we need to increment the index to account for the shift in elements from each insertion
    cntr, seq_num = 0, 1
    deals_with_ads = {}
    # results = {}
    all_deals.each_with_index do |rec, idx|
      # Always have an advertisement first
      if idx % ad_modulo == 0
        # pull an Ad from all_ads and insert it
        deals_with_ads[ "ad_#{seq_num}" ] = { :image => all_ads[ cntr ].image_url, 
                                              :url => all_ads[ cntr ].url 
                                            }
        seq_num += 1
        cntr += 1
      end

      deals_with_ads[ "deal_#{seq_num}" ] = all_deals[ idx ]
      seq_num += 1
      
      # if idx > 0
      # end
    end
    # output loop to make the hash that will be returned to the api_controller for conversion to json
    deals_w_ads = []
    deals_with_ads.each do |key, val|
      if key[0..1] != "ad"
        deals_w_ads.push( {
            :type                   => "deal",
            :name                   => "#{val.name}",
            :image                  => "#{val.image_url}", 
            :retailer_name          => "#{val.retailer.name}", 
            :retailer_address       => "#{val.retailer.address}",
            :discount_percent_text  => "#{val.discount_percent_text}",
            :price_text             => "#{val.price_text}",
            :distance               => "#{round_to(val.distance, 1)}"
        } )
        puts "********* #{key}: #{val.image_url}, #{val.retailer.name}, #{val.retailer.address}, #{val.discount_percent_text}, #{val.price_text}, #{round_to(val.distance, 1)}"
      else
        deals_w_ads.push( { :type   => "ad",
                            :image  => "#{val[:image]}", 
                            :url    => "#{val[:url]}" }
                        )
        puts "********* #{key}: #{val}"
      end
    end
    deals_w_ads
  end

  def self.deals_only( current_coords )
    all_deals = self.get_all_deals( current_coords )
  end
  
  def set_num_available
    self.num_available = self.num_offered
  end

=begin
api = ApiController.new
api.deals_with_ads( nil ) # nil defaults to Victoria::Application::GT_Coords
=end

=begin
          num_offered       num_available      num_redeemed
          =============   ================     ============
(stored)       1                        0           1
(posted)       5          (num_offered) 5      (unaffected)  
          =============   ================     =============
(new)          5                        5           1

NOTE: The value of num_available and num_redeemed is computed in the redemptions_controller when redemptions are made, and then the deal record is updated
with those values.  When the Deal's 'num_offered' is changed (the only attribute that can be changed w/o a redemption taking place), the logic is:

  new_num_offered = posted_num_offered => cannot be a negative number, handled above
  
  new_num_available = old_num_available + posted_num_offered => new_num_available cannot be a negative number
  
=end
# called from within here: validate :calc_new_num_available,   :on => :update, :if => lambda{ |obj| obj.num_offered_changed? }
  def calc_new_num_available
    # old_num_available = self.num_available
    # when num_offered changes, num_available cannot go below 0
    # new_num_available = self.num_available + self.num_offered
    # if new_num_available < 0
    #   self.errors[:base] << "ERROR: You cannot set 'Num Offered' to #{self.num_offered} because the new 'Num Available' would be negative (#{new_num_available}).\n"
    #   # { :result => false, 
    #   #   :message => "ERROR: You cannot set 'Num Offered' to #{self.num_offered} because the new 'Num Available' would be negative (#{new_num_available}).\n" }
    # else
      # can proceed with the update
      if self.num_offered == 0
        self.num_available = 0
      else
        self.num_available = self.num_available + self.num_offered        
      end
      # { :result => true, 
      #   :message => "There are now #{new_num_available} deals available"}
    # end  
    # total_redeemed = Redemption.where(:deal_id => self.id).sum('num_redeemed')
  end
  
  # called from redemptions_controller and DeviceRedemption
  def self.calc_deals_num_attributes( deal_id, num_redeemed )
    deal = self.find deal_id
    num_offered       = deal.num_offered
    new_num_available = deal.num_available - num_redeemed
    new_num_redeemed  = deal.num_redeemed + num_redeemed 
    if new_num_available < 0
      # self.errors[:base] << 
      { :result => false, 
        :message => "ERROR: You cannot redeem #{num_redeemed} because that would make the Deal's available quantity negative.  Currently you can redeem #{deal.num_available} of these deals.  You can adjust the Deal's 'Num Offered' and then redeem again\n",
        :reason =>  "ERROR: You cannot redeem #{num_redeemed} because that would make the Deal's available quantity negative"}
    else
      { :result => true, 
        :message => "There are now #{new_num_available} deals available", 
        :new_num_available  => new_num_available,
        :new_num_redeemed   => new_num_redeemed }
    end
  end
  
end

=begin

# Intersperse the Advertisements from "all_ads" every "ad_modulo" records remembering that after each insertion we need to increment the index to account for the shift in elements from each insertion
# deal_1: #<Deal:0x007fd712d20bb8> (add to hash)
# deal_2: #<Deal:0x007fd712d20bb8> (add to hash)
# deal_3: #<Deal:0x007fd712d20bb8> (add to hash)
# deal_4: #<Deal:0x007fd712d20bb8> (add to hash)
# deal_5: #<Deal:0x007fd712d20bb8> (add to hash)
# ad_6: #<Advertisement:0x007fd71332ccc8> (add to hash)
# deal_7: #<Deal:0x007fd712d208c0> (add to hash)
# deal_8: #<Deal:0x007fd712d208c0> (add to hash)
# deal_9: #<Deal:0x007fd712d208c0> (add to hash)
# deal_10: #<Deal:0x007fd712d208c0> (add to hash)
# ad_11: #<Advertisement:0x007fd71332c5e8> (add to hash)
# deal_12: #<Deal:0x007fd712d20550> (add to hash)
# deal_13: #<Deal:0x007fd712d20550> (add to hash)
# deal_14: #<Deal:0x007fd712d20550> (add to hash)
# deal_15: #<Deal:0x007fd712d20550> (add to hash)
# ad_16: #<Advertisement:0x007fd71332c160> (add to hash)

before_validation :has_unique_name?, :if => lambda{ |obj| obj.name_changed? || obj.retailer_id_changed? || obj.advertiser_id_changed? }

Deal.active.each do |deal|
  puts "#{deal.name}, #{deal.beg_date.to_s}, #{deal.end_date.to_s}"
end

Deal.all.each do |deal|
  puts "#{deal.name}, #{deal.beg_date.to_s}, #{deal.end_date.to_s}"
end

gem date_validator
:after
:before
:after_or_equal_to
:before_or_equal_to

And I mean simple. In your model:

validates :expiration_date,
          :date => {:after => Proc.new { Time.now },
                    :before => Proc.new { Time.now + 1.year } }
# Using Proc.new prevents production cache issues

If you want to check the date against another attribute, you can pass it a Symbol instead of a block:

# Ensure the expiration date is after the packaging date
validates :expiration_date,
          :date => {:after => :packaging_date}

For now the available options you can use are :after, :before, :after_or_equal_to and :before_or_equal_to.

If you want to specify a custom message, you can do so in the options hash:

validates :start_date,
  :date => {:after => Date.today, :message => 'must be after today'},
  :on => :create

Pretty much self-explanatory! :)

If you want to make sure an attribute is before/after another attribute, use:

validates :start_date, :date => {:before => :end_date }

=end

  # attr_accessor :end_date
  
  # validates_date_of :beg_date #, :date => {:after => Proc.new { Time.now }}
  
  # before_validation validate_date( :beg_date )

  # before_save :validate_end_date
  # 
  # def validate_end_date
  #   begin
  #     date = Date.parse(end_date.to_s)
  #   rescue ArgumentError
  #     errors.add(:end_date, "#{end_date}, Invalid Date")
  #   end
  # end

  # def self.convert_beg_date
  #   begin
  #     self.beg_date = Date.civil(self.year.to_i, self.month.to_i, self.day.to_i)
  #   rescue ArgumentError
  #     false
  #   end
  # end
  # 
  # def validate_beg_date
  #   errors.add("Beg Date", "is invalid.") unless convert_beg_date
  # end

