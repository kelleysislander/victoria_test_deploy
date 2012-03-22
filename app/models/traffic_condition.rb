class TrafficCondition < ActiveRecord::Base
  
  require 'time'
  
  # attr_accessible :traffic_data_type_id, :traffic_camera_id, :traffic_rating_id, :compass_point_id, :report_date, :other_source, :other_description, :other_address, :other_latitude, :other_longitude
  
  belongs_to  :traffic_camera
  belongs_to  :traffic_rating
  belongs_to  :traffic_data_type
  belongs_to  :compass_point
  
  paginates_per 10 # kaminari pagination
  
  validates_presence_of :traffic_rating_id, :report_date
  
  validates_uniqueness_of :traffic_camera_id, :scope => :report_date
  
=begin
                                      TrafficDataType id values vs. Field Input Requirements
                                      
  R = Required; N = Not Required

  traffic_data_type_id    traffic_camera_id   other_source    other_address   other_descr   other_latitude    other_longitude
  --------------------    -----------------   ------------    -------------   -----------   --------------    ---------------
  "LiveCam"      (1)            R                 N               N               N
  "Historical"   (2)            R                 N               N               N
                          ___________________________________________________________________________________________________
  "Other:Tweet"  (3)                                                                       lat/long will be geocoded 
  "Other:Email"  (4)            N                 N               R               R        using "other_address" which is
  "Other:Phone"  (5)                                                                       required for these values
                          ___________________________________________________________________________________________________
  "Other:Other"  (6)            N                 R               R               R
  
=end  

  def reset_coordinates
    self.other_latitude   = nil
    self.other_longitude  = nil
  end
  
  # required if traffic_data_type_id is "LiveCam" or "Historical"
  validates_presence_of :traffic_camera_id, 
    :if => Proc.new {|obj| (obj.traffic_data_type_id == TrafficDataType.where(:name => "LiveCam").first.id) || (obj.traffic_data_type_id == TrafficDataType.where(:name => "Historical").first.id)}, 
    :message => "required if Traffic Data Type is 'LiveCam' or 'Historical'"
  # required if traffic_data_type_id is "Other:Other","Other:Tweet", "Other:Email", or "Other:Phone"

  validates_presence_of :compass_point_id,
    :if => Proc.new { |obj| obj.traffic_data_type_id.to_s.count(TrafficDataType.other.map(&:id).join(",")) > 0 },
    :message => 'required if the Traffic Data Type is "Other:Other","Other:Tweet", "Other:Email", or "Other:Phone"'

  # required if traffic_data_type_id is "Other:Other"
  validates_presence_of :other_source, 
    :if => Proc.new {|obj| obj.traffic_data_type_id == TrafficDataType.where(:name => "Other:Other").first.id}, 
    :message => "required if Traffic Data Type is 'Other:Other'"

  # required id traffic_data_type_id is any of the "Other:*" values (ie. "Other:Other","Other:Tweet", "Other:Email", "Other:Phone")
  # NOTE: This does not work
  # validates_presence_of [:other_description, :other_address], 
  #   :if => Proc.new { |obj| TrafficDataType.other.map(&:id).join(",").include?(obj.traffic_data_type_id.to_s) },
  #   :message => "required if the Traffic Data Type is 'Other:Other','Other:Tweet', 'Other:Email', or 'Other:Phone'"
  # but this does:
  # required id traffic_data_type_id is any of the "Other:*" values (ie. "Other:Other","Other:Tweet", "Other:Email", "Other:Phone")
  # validates_presence_of [:other_description, :other_address], 
  #   :if => Proc.new { |obj| 
  #     obj.traffic_data_type_id == TrafficDataType.where(:name => "Other:Tweet").first.id || 
  #     obj.traffic_data_type_id == TrafficDataType.where(:name => "Other:Email").first.id || 
  #     obj.traffic_data_type_id == TrafficDataType.where(:name => "Other:Phone").first.id || 
  #     obj.traffic_data_type_id == TrafficDataType.where(:name => "Other:Other").first.id  },
  #   :message => "required if the Traffic Data Type is 'Other:Other','Other:Tweet', 'Other:Email', or 'Other:Phone'"
  # and this does work. It seems like you have to put any reference to "obj" FIRST in the expression, not embedded within it

  validates_presence_of [:other_description, :other_address], 
    :if => Proc.new { |obj| obj.traffic_data_type_id.to_s.count(TrafficDataType.other.map(&:id).join(",")) > 0 },
    :message => 'required if the Traffic Data Type is "Other:Other","Other:Tweet", "Other:Email", or "Other:Phone"'
    
  validates_presence_of [:other_latitude, :other_longitude],
    :if => Proc.new { |obj| obj.traffic_data_type_id.to_s.count(TrafficDataType.other.map(&:id).join(",")) > 0 },
    :message => 'cannot be blank; the lat / long coordinates are acquired by supplying a valid address, which is requred if the Traffic Data Type is "Other:Other","Other:Tweet", "Other:Email", or "Other:Phone"'
    
  # NOTE: The geocoding was already done by the googlemaps API v3 called from within the traffic_condition form so this next stuff is not needed, but left in case we need to restore it
  # geocode if other_address is present
  # geocoded_by :other_address, :latitude  => :other_latitude, :longitude => :other_longitude
  
  # Conditionally reset coordinates and geocode and conditionally null out latitude / longitude so we can tell afterwards by their presence if the after_validation :geocode worked correctly
  # geocoding is done for all of the "Other:*" values of TrafficDataType
  # before_validation :reset_coordinates, :if => lambda{ |obj| TrafficDataType.other.map(&:id).join(",").include?(obj.traffic_data_type_id.to_s) }
  # after_validation  :geocode,           :if => lambda{ |obj| TrafficDataType.other.map(&:id).join(",").include?(obj.traffic_data_type_id.to_s) }
=begin
tz_offset = (Time.zone.utc_offset / 3600).to_s << ":00"
TrafficCondition.current_conditions( tz_offset ).each do |rec|
  puts "#{rec.traffic_camera_id}, #{rec.latitude}, #{rec.longitude}, #{rec.report_date}, #{rec.report_date_str}, #{rec.source}, #{rec.traffic_rating_id}, #{rec.compass_point_name}, #{rec.rating_description}, #{rec.alert_message}, #{rec.traffic_camera_name}"
  # puts "#{rec.traffic_camera_id}, #{rec.latitude}, #{rec.longitude}, #{rec.report_date.localtime.strftime("%m/%d/%Y - %I:%M%p")},  #{rec.source}, #{rec.traffic_rating_id}, #{rec.compass_point_name}"
end

#{tz_offset}

Edit some data in traffic_condition_historicals
# to update the traffic_conditions records to today's date: UPDATE traffic_conditions SET report_date = CONCAT(CURDATE(), ' ', time(report_date));

def unique_randoms(n, max = nil)
 seen = {}
 n.times do
   x = rand max
   redo if seen[x] 
   seen[x] = true
 end
 seen.keys
end

  unique_randoms(2, 8+2)
  unique_indexes = unique_randoms( 2, 8 + 2 ).unshift
=end

  def self.unique_randoms(n, max = nil)
   seen = { 0 => 0 }
   n.times do
     x = rand max
     puts "left: #{seen.values[seen.size-1].abs}, right: #{x.abs}  diff: #{seen.values[seen.size-1].abs - x.abs}"
     redo if seen[x] || ( (seen.values[seen.size-1].abs - x.abs).abs == 1 )
     seen[x] = x
   end
   seen.keys.sort[1..2]
  end
  
  def self.traffic_alerts_with_ads( current_coords ) 
    alerts        = current_conditions( Map::TZ_Offset )
    # randomly select a splash ad and a regular sponsored ad to insersperse within the "alerts", above
    featured_ads  = Advertisement.active.featured.order('rand()').limit(1)
    regular_ads   = Advertisement.active.regular.order('rand()').limit(2)
    # all_ads       = featured_ads + regular_ads     
    # place the Featured Ad first then put the 2 regular ads somewhere between the 2nd and last alert + 1 position
    alerts_with_ads = []
    cntr, seq_num = 0, 1
    results = {}
    # get 2 random positions between 1 (0 is the first ad) and (# of alerts.size + 2) "2" allows for the 3 advertisement additions to the number of alerts; we're using the result as an element index so it is 1 less than the size
    unique_indexes = self.unique_randoms( 2, alerts.size + 1 ) # ie. [4, 8]
    alerts.each_with_index do |rec, idx|
      # Always have a "Featured Sponsored" ad first
      if idx == 0
        # puts "feat_#{seq_num}"
        alerts_with_ads.push( { :type => "featured", :image =>  featured_ads[ idx ].image_url, :url => featured_ads[ idx ].url } )
        seq_num += 1
        cntr += 1
      end
      # now insert the "Regular Sponsored" ads as we iterate over "all_alerts"
      # insert the first ad
      if (alerts_with_ads.size-1 == unique_indexes[0]) # || alerts_with_ads.size-1 == unique_indexes[1])
        # puts "reg_#{seq_num}"
        alerts_with_ads.push( { :type => "regular",  :image => regular_ads[ 0 ].image_url } )
        seq_num += 1
      end
      # insert the second ad
      if (alerts_with_ads.size-1 == unique_indexes[1])
        # puts "reg_#{seq_num}"
        alerts_with_ads.push( { :type => "regular",  :image =>  regular_ads[ 1 ].image_url } )
        seq_num += 1
      end
      # insert the alerts
      # puts "alert_#{seq_num}"
      alerts_with_ads.push( alerts[ idx ] )
      seq_num += 1
    end
    alerts_with_ads
  end
  
  def self.current_conditions( tz_offset )
    self.find_by_sql("
    SELECT
      now() as now,
      final.*
      FROM 
      (
        SELECT
          tch.report_date as tch_rep_date,
          CASE WHEN tc.traffic_camera_id IS NULL THEN tch.traffic_camera_id ELSE tc.traffic_camera_id END as traffic_camera_id,
          tch.traffic_camera_name,
          tch.latitude,
          tch.longitude,
          tch.compass_point_name,
          tch.rating_description,
          CASE WHEN tc.traffic_camera_id IS NULL THEN tch.report_date       ELSE tc.report_date       END as report_date,
          CASE WHEN tc.traffic_camera_id IS NULL THEN tch.report_date_str   ELSE tc.report_date_str   END as report_date_str,
          CASE WHEN tc.traffic_camera_id IS NULL THEN tch.rec_type          ELSE tc.rec_type          END as source,
          CASE WHEN tc.traffic_camera_id IS NULL THEN tch.traffic_rating_id ELSE tc.traffic_rating_id END as traffic_rating_id,
          CASE WHEN tc.traffic_camera_id IS NULL THEN tch.rating            ELSE tc.rating            END as rating,
          CASE WHEN tc.traffic_camera_id IS NULL THEN tch.alert_message     ELSE tc.alert_message     END as alert_message,
          tch.report_date_beg,
          tch.report_date_end,
          tch.url
        FROM
        (
        -- selects the most recent report_date for the current day_of_week per traffic_camera_id from traffic_condition_historicals
        SELECT 
          tch.traffic_camera_id,
          tc.name as traffic_camera_name,
          tc.latitude,
          tc.longitude,
          tch.traffic_rating_id,
          tr.rating,
          tr.description as rating_description,
          cp.name as compass_point_name,
          '' as alert_message,
          TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ) as report_date,
          DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') as report_date_str,
          -- midpoints based on tch.time_of_day
          -- DATE_SUB(TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ), INTERVAL '7:30' MINUTE_SECOND) as report_date_beg,
          -- DATE_ADD(TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', tch.time_of_day,':00'), '%Y-%m-%d %T') ), INTERVAL '7:30' MINUTE_SECOND) as report_date_end,
          -- midpoints based on NOW()
          DATE_SUB(TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', DATE_FORMAT(now(), '%T')), '%Y-%m-%d %T') ), INTERVAL '7:30' MINUTE_SECOND) as report_date_beg,
          DATE_ADD(TIMESTAMP( DATE_FORMAT(CONCAT(YEAR(CURDATE()),'-',LPAD(MONTH(CURDATE()),2,'0'),'-', DAYOFMONTH(curdate()), ' ', DATE_FORMAT(now(), '%T')), '%Y-%m-%d %T') ), INTERVAL '7:30' MINUTE_SECOND) as report_date_end,
          tc.url,
          'h' as rec_type
        FROM traffic_condition_historicals tch 
        JOIN traffic_cameras tc ON tc.id = tch.traffic_camera_id
        JOIN traffic_ratings tr ON tr.id = tch.traffic_rating_id
        JOIN compass_points  cp ON cp.id = tc.compass_point_id
        WHERE 
          tch.day_of_week + 1 = DAYOFWEEK( curdate()  ) AND
          tch.time_of_day = (SELECT MAX(time_of_day) FROM traffic_condition_historicals WHERE time_of_day <= DATE_FORMAT( now(), '%T'))
        GROUP BY tch.traffic_camera_id
        ORDER BY
        tch.traffic_camera_id
        ) tch
        -- and joins to the actual traffic_conditions based on traffic_camera_id and report_date_beg / report_date_end
        LEFT JOIN
        (
        SELECT
          tc.traffic_camera_id,
          c.name as traffic_camera_name,
          CASE WHEN tc.traffic_camera_id IS NULL 
            THEN tc.other_latitude ELSE c.latitude END as latitude,
          CASE WHEN tc.traffic_camera_id IS NULL
            THEN tc.other_longitude ELSE c.longitude END as longitude,
          tc.traffic_rating_id,
          tr.rating,
          tr.description as rating_description,
          cp.name as compass_point_name,
          tc.alert_message,
          CONVERT_TZ(tc.report_date,'+00:00','#{tz_offset}') as report_date,
          DATE_FORMAT(CONVERT_TZ(tc.report_date,'+00:00','#{tz_offset}'), '%Y-%m-%d %T') as report_date_str,
          'c' as rec_type
        FROM traffic_conditions tc
        LEFT JOIN traffic_cameras c ON c.id = tc.traffic_camera_id
        JOIN traffic_ratings tr ON tr.id = tc.traffic_rating_id 
        JOIN compass_points  cp ON cp.id = c.compass_point_id 
        ) tc
        ON
          -- the actual taffic_conditions report_date must fall within 
          tc.report_date >= tch.report_date_beg AND tc.report_date < tch.report_date_end AND
          tc.traffic_camera_id = tch.traffic_camera_id
        ORDER BY
          tch.traffic_camera_id,
            CONVERT_TZ(tch.report_date,'+00:00','#{tz_offset}') DESC
    ) final
    GROUP BY
      traffic_camera_id
    ORDER BY
      traffic_camera_id;"
    )
  end
  
end
