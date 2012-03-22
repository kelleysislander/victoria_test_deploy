class Advertisement < ActiveRecord::Base
  
  paginates_per 10 # kaminari pagination
  
  belongs_to  :advertisement_type
  belongs_to  :retailer
  belongs_to  :advertiser
  
  has_one     :deal, :through => :retailers
  
  # attr_accessible :retailer_id, :advertiser_id, :advertisement_type_id, :name, :description, :content, :beg_date, :end_date, :image, :url
    
  mount_uploader :image, AdvertisementImageUploader
  
  # NOTE: "retailer_id" is optional so it is not required, as in the case where an Advertisement is an independent entity and can exist
  # separate from the Retailer (it still must have a parent Advertiser, and therefore an "advertiser_id"): 
  validates_presence_of :advertiser_id, :advertisement_type_id, :retailer_id, :name, :description, :beg_date, :end_date
  validates_presence_of :image
  validates_presence_of :url, :if => Proc.new { |obj| obj.advertisement_type_id == (AdvertisementType.where(:advertisement_type => "Splash").first.id) }, :message => "required if 'Advertisement Type' is 'Splash'"
  
  before_validation :has_unique_name?, :if => lambda{ |obj| obj.name_changed? || obj.retailer_id_changed? || obj.advertiser_id_changed? }
  
  validates_length_of :name,        :within => 5..255,  :too_long => "Maximum size for 'Name' is 255.",    :too_short => "Minimum size for 'Name' is 5."
  validates_length_of :description, :within => 5..255,  :too_long => "Maximum size for 'Description' is 255.", :too_short => "Minimum size for 'Description' is 5."
  
  validates :beg_date, :date => {:before_or_equal_to => :end_date }, :if => lambda{ |obj| obj.end_date != nil } # gem date_validator
  
  # NOTE: 'name' is unique for the combination of the retailer and advertiser
  def has_unique_name?
    result = Advertisement.exists?(['name = ? and retailer_id = ? and advertiser_id = ?', self.name, self.retailer_id, self.advertiser_id])
    if result
      self.errors[:base] << "The Advertisement Name / Retailer / Advertiser is already taken.\n"
    end
  end

  scope :active,      lambda{ where('CURDATE() >= beg_date AND CURDATE() <= end_date') }
  scope :splash,      lambda{ { :conditions => ["advertisements.advertisement_type_id = (SELECT id FROM advertisement_types WHERE advertisement_type = 'Splash')"] } }
  scope :fullscreen,  lambda{ { :conditions => ["advertisements.advertisement_type_id = (SELECT id FROM advertisement_types WHERE advertisement_type = 'Full Screen')"] } }
  scope :featured,    lambda{ { :conditions => ["advertisements.advertisement_type_id = (SELECT id FROM advertisement_types WHERE advertisement_type = 'Featured Sponsored')"] } }
  scope :regular,     lambda{ { :conditions => ["advertisements.advertisement_type_id = (SELECT id FROM advertisement_types WHERE advertisement_type = 'Regular Sponsored')"] } }

=begin

relationship between advertisements, retailers, and advertisers:

SELECT
  a.retailer_id as advertiser_retailer_id,
  advment.retailer_id as advertisement_retailer_id,
  advment.advertiser_id as advertisement_advertiser_id,
  advment.name as advertisement_name,
--  a.name as advertiser_name,
  IFNULL(a.name, r.name) as advertiser,
  r.name as retailer_name,
  CASE 
    WHEN a.retailer_id IS NULL
    THEN 'N' 
    ELSE 'Y' 
  END as "advertiser_is_retailer?"
FROM advertisements advment
JOIN retailers r ON r.id = advment.retailer_id
JOIN advertisers a ON a.id = advment.advertiser_id
LEFT JOIN retailers r_as_a ON r_as_a.id = advment.retailer_id;

=end

end
