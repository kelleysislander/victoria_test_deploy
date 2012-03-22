module Web::Deals::AdvertiserHelper

  def options_for_advertiser_list
    options = display_options_for_list
    list = options_for_select(options[0],options[1].to_i)
  end

  def display_options_for_list
    val, selected = ""
    opts = []
    Advertiser.find(:all, :include => :retailer).each do |a|
      if a.retailer_id then disp = "#{a.retailer.name} (R)" else disp = "#{a.name} (A)" end
      if a.id == @deal.advertiser_id
        selected = a.id
        val = ["#{disp}", a.id]
      else
        val = ["#{disp}", a.id]
      end
      opts << val
    end
    return [opts, selected]
  end
  
  # def display_options_for_list
  #   advertisers = Advertiser.find(:all, :include => :retailer)
  #   val, selected = ""
  #   opts = []
  #   advertisers.each do |a|
  #     if a.retailer_id
  #       val = ["#{a.retailer.name} (R)", a.retailer.id]
  #       selected = a.retailer.id if a.retailer.id == @deal.retailer_id
  #     else
  #       val = ["#{a.name} (A)", a.id] 
  #       selected = a.id if a.id == @deal.advertiser_id
  #     end
  #     opts << val
  #   end
  #   return [opts, selected]
  # end

end

=begin
<select id="deal_advertiser_id" name="deal[advertiser_id]" style="width: auto;"><option value="">Choose Advertiser</option>
- Advertiser.find(:all, :include => :retailer).each do |a|
  - if a.retailer_id then disp = "#{a.retailer.name} (A)" else disp = "#{a.name} (R)" end
  - if a.id == @deal.advertiser_id # if the Advertiser record has a retailer_id then we show that Advertiser as "selected"
    <option value="#{a.id}, #{a.retailer_id} top" selected="selected">#{disp}</option>
  - else # The Advertiser does not have a retailer_id so we show as "selected" where the Advertiser.id == @advertisement.advertiser_id
    <option value="#{a.id}, #{a.retailer_id} bot" #{(a.id == @deal.advertiser_id) ? selected="selected" : ""}>#{a.name} (A)</option>
</select>

=end