class Redemption < ActiveRecord::Base
  
  require 'validations'
  
  attr_accessible :account_id, :deal_id, :num_redeemed
  
  belongs_to  :deal

  has_many :retailers, :through => :deals
  
  validates_presence_of :deal_id, :num_redeemed
  
  validates_numericality_of :num_redeemed
  validates_positive        :num_redeemed
  
  RedemptionType = [
    # Displayed     stored in DB
    [ "Social",           "S"     ],
    [ "GetIt",            "G"     ]
  ]
  
  # NOTE: The sum of num_redeemed is a grand total for all redemptions for this deal.  Since the 'num_offered' for a deal can be 
  # changed at any time, thus altering the deal's 'num-available', the way to know how many actual redemptions is to sum them
  # from the redemptions records
  
=begin

update deals set num_offered = 1 where id = 11;
update deals set num_available = 1 where id = 11;
update deals set num_redeemed = 0 where id = 11;

select * from redemptions;

select * from deals where id = 11;

delete from redemptions where id > 0;

  
  before_validation :has_unique_name?, :if => lambda{ |obj| obj.name_changed? || obj.retailer_id_changed? || obj.advertiser_id_changed? }
  
  validates_length_of :name,        :within => 5..255,  :too_long => "Maximum size for 'Name' is 255.",    :too_short => "Minimum size for 'Name' is 5."
  validates_length_of :description, :within => 5..255,  :too_long => "Maximum size for 'Description' is 255.", :too_short => "Minimum size for 'Description' is 5."
  
  validates :beg_date, :date => {:before_or_equal_to => :end_date }, :if => lambda{ |obj| obj.end_date != nil }
  
  # NOTE: 'name' is unique for the combination of the retailer and advertiser
  def has_unique_name?
    result = Advertisement.exists?(['name = ? and retailer_id = ? and advertiser_id = ?', self.name, self.retailer_id, self.advertiser_id])
    if result
      self.errors[:base] << "The Advertisement Name / Retailer / Advertiser is already taken.\n"
    end
  end
=end  
end
