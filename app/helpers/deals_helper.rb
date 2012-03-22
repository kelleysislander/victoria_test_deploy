module DealsHelper
  
  def featured( in_val )
    Deal::Flags.each do |val, idx|
      return val if idx == in_val 
    end
  end
  
  def size( in_array )
    "#{in_array[0]}x#{in_array[1]}"
  end
  
  def days_left_1( deal )
    duration = (deal.end_date - Date.today).to_i
    if duration != 0
      pluralize( (deal.end_date - Date.today).to_i, "day" )
    else
      "Last"
    end
  end
  
  def days_left_2( deal )
    duration = (deal.end_date - Date.today).to_i
    if duration != 0
      "left"
    else
      "Day!"
    end
  end
  
  def deal_tag_text( deal )
    if deal.deal_tag_text.include?("$")
      left_part = deal.deal_tag_text.split("$")[0]
      right_part = "$" << deal.deal_tag_text.split("$")[1]
      return left_part, right_part
    else
      "Not"
    end
  end
  
end
