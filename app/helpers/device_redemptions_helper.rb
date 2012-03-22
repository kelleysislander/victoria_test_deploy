module DeviceRedemptionsHelper
  
  def redemption_type( in_val )
    Redemption::RedemptionTypes.each do |val, idx|
      return val if idx == in_val 
    end
  end
  
end
