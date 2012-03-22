class DealSeed < ActiveRecord::Base
  
  set_table_name 'deals'
  
  require 'validations' # explicitly loaded here because it is only needed here 
  
  paginates_per 8 # kaminari pagination
  
  # attr_accessible :deal_type_id, :retailer_id, :advertiser_id, :name, :description, :content, :featured_flag, :num_offered, :num_available, :num_redeemed, :beg_date, :end_date, :created_at, :updated_at, :badge_text, :badge_path, :image
  
  mount_uploader :image, DealImageUploader
  
  auto_strip  :name, :description, :content, :num_offered, :num_available, :num_redeemed, :badge_path
  slash_strip :badge_text
  
  belongs_to  :deal_type
  belongs_to  :retailer
  belongs_to  :advertiser
  
  has_many    :redemptions
  has_many    :advertisements,  :through => :retailers
  has_one     :account,         :through => :retailers 
  
  validates_presence_of :deal_type_id, :retailer_id, :advertiser_id, :name, :description, :featured_flag, :num_offered
  # NOTE: BK used to run seeds.rb 
  # validates_presence_of :image
  # end of used to run seeds.rb 
  validates_presence_of :beg_date, :end_date
  
  validates_length_of :name,        :within => 5..255,  :too_long => "Maximum size for 'Name' is 255",         :too_short => "Minimum size for 'Name' is 5"
  validates_length_of :description, :within => 5..255,  :too_long => "Maximum size for 'Description' is 255",  :too_short => "Minimum size for 'Description' is 5"
  # validates_length_of :badge_text,  :within => 3..12,   :too_long => "Maximum size for 'Badge Text' is 12",    :too_short => "Minimum size for 'Badge Text' is 3"
  
  validates_numericality_of   :num_offered
  validates_positive_or_zero  :num_offered #, :if => (1 == 2) # lambda{ |obj| obj.num_offered == 999 }

  validates :beg_date, :date => {:before_or_equal_to => :end_date }, :if => lambda{ |obj| obj.end_date != nil } # gem date_validator
  
  # validate :calc_deals_num_attributes #, :on => :create
  # after_validation :calc_deals_num_available #, :on => :create

  scope :active,              lambda{ where('(Beg_Date <= CURDATE() AND End_Date IS NULL) OR (Beg_Date <= CURDATE() AND End_Date >= CURDATE())') }
  scope :featured,            lambda{ { :conditions => ['deals.featured_flag = 1'] } }
  scope :nonfeatured,         lambda{ { :conditions => ['deals.featured_flag = 0'] } }
  scope :active_featured,     lambda { active.featured }
  scope :active_nonfeatured,  lambda { active.nonfeatured }
  
  before_save :set_num_available,     :on => :create # only set this attribute when the new record is first created
  validate :calc_new_num_available,   :on => :update, :if => lambda{ |obj| obj.num_offered_changed? }
  
  Flags = [
    # Displayed     stored in DB
    [ "No",             0     ],
    [ "Yes",            1     ]
  ]

  def set_num_available
    self.num_available = self.num_offered
  end
  
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
# called from deals_controller
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
  
  # called from redemptions_controller
  def self.calc_deals_num_attributes( deal_id, num_redeemed )
    deal = self.find deal_id
    num_offered       = deal.num_offered
    new_num_available = deal.num_available - num_redeemed
    new_num_redeemed  = deal.num_redeemed + num_redeemed 
    if new_num_available < 0
      # self.errors[:base] << 
      { :result => false, 
        :message => "ERROR: You cannot redeem #{num_redeemed} because that would make the Deal's available quantity negative.  Currently you can redeem #{deal.num_available} of these deals.  You can adjust the Deal's 'Num Offered' and then redeem again\n" }
    else
      { :result => true, 
        :message => "There are now #{new_num_available} deals available", 
        :new_num_available  => new_num_available,
        :new_num_redeemed   => new_num_redeemed }
    end
  end
  
end

=begin

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

