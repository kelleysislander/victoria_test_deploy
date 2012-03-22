class DeviceRedemption < ActiveRecord::Base
  
  belongs_to :deal
  
  paginates_per 20 # kaminari pagination
  
  # validates_uniqueness_of :device_id, :scope => :deal_id, :if => :lambda{ |obj| obj.redemption_type == "G" }
  # validates_uniqueness_of :device_id, :scope => [:deal_id, :redemption_date], :if => :lambda{ |obj| obj.redemption_type == "S" }
  
  # attr_accessible :device_uid, :deal_id, :redemption_type, :redemption_date
  
  validates_presence_of :device_uid, :deal_id, :redemption_type, :redemption_date
  
  # DeviceRedemption.redemption_valid( "G", 'guid-1', 1 )
  # DeviceRedemption.redemption_valid( "S", 'guid-1', 1 ), called from api_controller
  # http://localhost:3000/api/redeem.json?auth_token=xxF4R2hty51edFpYuepq&redemption_type=G&device_uid=guid-1&deal_id=1
  # http://localhost:3000/api/redeem.json?auth_token=xxF4R2hty51edFpYuepq&redemption_type=S&device_uid=guid-1&deal_id=1
  def self.redemption_valid( redemption_type, device_uid, deal_id )
    
    calc = Deal.calc_deals_num_attributes( deal_id, 1 )
    
    if redemption_type == "G"
      
      rec = DeviceRedemption.where("device_uid = '#{device_uid}' AND deal_id = #{deal_id} AND redemption_type = 'G'").includes(:deal).first
      if rec
        return { :result => false, :message => "ERROR: Redemption for '#{rec.deal.name}' already done" }
      else
        if calc[:result] == true
          return { :result => true, :redemption_passphrase => Deal.find( deal_id ).redemption_passphrase, :message => "Success: Can Redeem => there are #{calc[:new_num_available]} Deals remaining", :new_num_available => calc[:new_num_available], :new_num_redeemed => calc[:new_num_redeemed] }
        else
          return { :result => false, :message => "Success: Cannot Redeem => there are #{calc[:new_num_available]} Deals remaining" }
        end
      end
      
    else # redemption_type == "S"
      # rec = DeviceRedemption.where("device_uid = 'guid-1' AND deal_id = 1 AND redemption_type = 'S'").includes(:deal).first
      rec = DeviceRedemption.where("device_uid = '#{device_uid}' AND deal_id = #{deal_id} AND redemption_type = 'S'").includes(:deal).first
      if rec
        days_since_last = ( Date.today - rec.redemption_date ).to_i
        if days_since_last < rec.deal.social_discount_interval
          return { :result => false, :message => "ERROR: Cannot redeem again until #{rec.redemption_date + rec.deal.social_discount_interval}" }
        else
          if calc[:result] == true
            return { :result => true, :redemption_passphrase => Deal.find( deal_id ).redemption_passphrase, :message => "Success: Can Redeem Additional Social Discount Redemption => there are #{calc[:new_num_available]} Deals remaining", :new_num_available => calc[:new_num_available], :new_num_redeemed => calc[:new_num_redeemed] }
          else
            # return false with an error message
            return { :result => false, :message => calc[:reason] }
          end
        end
      else
        return { :result => true, :redemption_passphrase => Deal.find( deal_id ).redemption_passphrase, :message => "Success: First Social Discount Redemption => there are #{calc[:new_num_available]} Deals remaining", :new_num_available => calc[:new_num_available], :new_num_redeemed => calc[:new_num_redeemed] }
      end
      
    end # if redemption_type == "G"
    
  end

end

=begin

NOTE: The concept here is that a particular user, as identified by a unique "device_id" (GUID) can only redeem a "GetIt" deal once, and can get the discount via 
a "social unlock" every n days as set by deal.social_discount_interval value.  To enforce this we store redemptions in this model.. The logic for redemptions is in "self.redemption_valid", above

 calc[:new_num_available], :num_redeemed => calc[:new_num_redeemed]
  # DeviceRedemption.get_it_redemption_valid( 'guid-1', 1 )
  def self.get_it_redemption_valid( device_uid, deal_id ) # only one redemption of type 'G'etIt can exist
    rec = DeviceRedemption.where("device_uid = '#{device_uid}' AND deal_id = #{deal_id} AND redemption_type = 'G'").includes(:deal).first
    if rec
      return { :result => false, :message => "ERROR: Redemption already done" }
    else
      return { :result => true, :message => "Success: Can Redeem" }
    end
  end
  
  # DeviceRedemption.social_discount_redemption_valid( 'guid-1', 1 )
  def self.social_discount_redemption_valid( device_uid, deal_id ) # can only redeem every 'deals.social_discount_interval' days type = 'S'ocial
    rec = DeviceRedemption.where("device_uid = '#{device_uid}' AND deal_id = #{deal_id} AND redemption_type = 'S'").includes(:deal).first
    calc = Deal.calc_deals_num_attributes( deal_id, 1 )
    if rec
      days_since_last = Date.today - rec.redemption_date
      if days_since_last < deal.social_discount_interval
        return { :result => false, :message => "ERROR: Cannot redeem again until #{Date.today + days_since_last}" }
      else
        # puts "calc[:result] = #{calc[:result]}"
        if calc[:result] == true
          return { :result => true, :message => "Success: Additional Social Discount Redemption " }
        else
          # return false with an error message
          return { :result => false, :message => calc[:reason] }
        end
      end
    else
      return { :result => true, :message => "Success: First Social Discount Redemption" }
    end
  end
=end
