class RedemptionPassphrase < ActiveRecord::Base
  # NOTE:  Thsi was originally intended to be used to redeem deals where the passphrase would be date-ranged and apply to all deals
  # then the client decide to associate  the passphrase with the deeal as an attrib of the deal model.  This and all of its environs are obsolete
  
  # attr_accessible :passphrase, :beg_date, :end_date
  
  paginates_per 20 # kaminari pagination
  
  validates :beg_date, :date => {:before_or_equal_to => :end_date } # gem date_validator
  validate  :beg_date_valid
  
  validates_presence_of :passphrase, :beg_date, :end_date
  
  validates_uniqueness_of :passphrase, :scope => :beg_date
  
  def beg_date_valid
    rec = RedemptionPassphrase.order("end_date desc").limit(1).first
    if rec
      self.errors.add(:beg_date, "'#{beg_date}', cannot be less than or equal to the last End Date (#{rec.end_date})") if beg_date <= rec.end_date
    end
  end
  
end
