module ApplicationHelper
  
  #  Example usage:
  #  num = 138.249
  #  round_to(num, 2) => 138.25
  def round_to(num, precision)
    (num * 10**precision).round.to_f / 10**x
  end

  def mil_to_std( in_mil_time )
    DateTime.strptime(in_mil_time, '%H%M').strftime('%l:%M%p')
  end
  
  def disp_date(indate)
    if indate.nil?
      ""
    else
      indate.strftime("%m/%d/%Y")
    end
  end

  def disp_date_ymd(indate)
    if indate.nil?
      ""
    else
      indate.strftime("%Y-%m-%d")
    end
  end

  def get_date
    Time.now.strftime("%Y-%m-%d")
  end

  def get_date_time
    Time.now.strftime("%m/%d/%Y - %I:%M:%S%P")
  end

  def disp_date_time(indate)
    if indate.nil?
      ""
    else
      indate.localtime.strftime("%m/%d/%Y - %I:%M%p")
      # strftime("%m/%d/%Y - %I:%M:%S%p")
    end
  end
  
  def disp_date_hms(indate)
    if indate.nil?
      ""
    else
      indate.localtime.strftime("%m/%d/%Y - %I:%M:%S%P")
    end
  end
  
  def day_mon_year(date)
    date.strftime("%e %b %Y").strip
    rescue
  end
  
  def valid_date?( in_date_string )
    if !in_date_string
      return false
    else
      begin
         date = DateTime.parse( in_date_string )
      rescue ArgumentError
         return false
      end
      disp_date_ymd( date )
    end
  end
  
  def submit_button(text='Submit', *optional_classes)
    classes = "miisubmit #{optional_classes.join(" ")}".strip
    raw "<input type='submit' class='#{classes}' value='#{text}'>"
  end
  
  def guatemala_country
    [
      [ "Guatemala", "Guatemala" ]
    ]
  end
  
  def us_states
    [
      [ "Alabama", "AL" ],
      [ "Alaska", "AK" ],
      [ "Arizona", "AZ" ],
      [ "Arkansas", "AR" ],
      [ "California", "CA" ],
      [ "Colorado", "CO" ],
      [ "Connecticut", "CT" ],
      [ "Delaware", "DE" ],
      [ "Florida", "FL" ],
      [ "Georgia", "GA" ],
      [ "Hawaii", "HI" ],
      [ "Idaho", "ID" ],
      [ "Illinois", "IL" ],
      [ "Indiana", "IN" ],
      [ "Iowa", "IA" ],
      [ "Kansas", "KS" ],
      [ "Kentucky", "KY" ],
      [ "Louisiana", "LA" ],
      [ "Maine", "ME" ],
      [ "Maryland", "MD" ],
      [ "Massachusetts", "MA" ],
      [ "Michigan", "MI" ],
      [ "Minnesota", "MN" ],
      [ "Mississippi", "MS" ],
      [ "Missouri", "MO" ],
      [ "Montana", "MT" ],
      [ "Nebraska", "NE" ],
      [ "Nevada", "NV" ],
      [ "New Hampshire", "NH" ],
      [ "New Jersey", "NJ" ],
      [ "New Mexico", "NM" ],
      [ "New York", "NY" ],
      [ "North Carolina", "NC" ],
      [ "North Dakota", "ND" ],
      [ "Ohio", "OH" ],
      [ "Oklahoma", "OK" ],
      [ "Oregon", "OR" ],
      [ "Pennsylvania", "PA" ],
      [ "Rhode Island", "RI" ],
      [ "South Carolina", "SC" ],
      [ "South Dakota", "SD" ],
      [ "Tennessee", "TN" ],
      [ "Texas", "TX" ],
      [ "Utah", "UT" ],
      [ "Vermont", "VT" ],
      [ "Virginia", "VA" ],
      [ "Washington", "WA" ],
      [ "West Virginia", "WV" ],
      [ "Wisconsin", "WI" ],
      [ "Wyoming", "WY" ]
    ]
    
  end
end
