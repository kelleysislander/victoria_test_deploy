class MapsController < ApplicationController
  
  # authorize_resource # => there is no "Map" table in the DB
  before_filter :authenticate_user!

  layout :choose_layout
  # layout :false

  # cond_params => {:retailer_category_id=>0, :retailer_name=>"'%%'", :retailer_addr=>"'%%'", :radius_distance=>5, :beg_date=>"2012-02-15", :end_date=>"2012-02-15", :location_addr=>"'9666 Whitehurst Dr, Dallas, TX, 75243'"}
  # NOTE: This is the main "deals" screen where the pins are dropped and the infobubbles are created with separate tabs for "Location" and each "Deal"
  # Use this address to search: 8 Calle 3-67 Zona 10, Guatemala City, Guatemala => [14.643109, -90.522800]
  # Deal.active.notapreview.includes(:retailer).near( [14.643109, -90.5228] , 5, { :units => :km } ) 
  def index
    if params[:search]
      radius_distance   = params[:search]['radius_distance']
      current_lat       = params[:search]['current_lat'].to_f
      current_lng       = params[:search]['current_lng'].to_f
      latlng = []; latlng.push( params[:search]['current_lat'].to_f ); latlng.push( params[:search]['current_lng'].to_f )
    end
    @deals = Deal.active.notapreview.includes(:retailer).near(latlng, (radius_distance) ? radius_distance : Victoria::Application::RadiusDistance, { :units => :km }).order('rand()')
    if latlng.size > 0
      @locations = Retailer.has_lat_long.where("(deals.beg_date <= '#{Date.today.to_s}' AND deals.end_date >= '#{Date.today.to_s}') AND deals.active_flag = 1").includes(:deals).near( latlng, radius_distance, { :units => :km }) #.page(params[:page]).per(10)
    else
      @locations = Retailer.has_lat_long.where("(deals.beg_date <= '#{Date.today.to_s}' AND deals.end_date >= '#{Date.today.to_s}') AND deals.active_flag = 1").includes(:deals)
    end
    locations_coordinates = locations_coords()
    if locations_coordinates.size > 0
      @center_lat_lng = Geocoder::Calculations.geographic_center(locations_coordinates)
    else # if all else fails, center on this location
      @center_lat_lng = Geocoder.coordinates("Guatemala City, Guatemala")
    end

    # Now get the traffic conditions (alerts) and put the appropriate icons on the map
    # tz_offset = (Time.zone.utc_offset / 3600).to_s << ":00"
    # TrafficCondition.current_conditions( tz_offset ).each do |rec|
    #   puts "#{rec.traffic_camera_id}, #{rec.latitude}, #{rec.longitude}, #{rec.report_date}, #{rec.report_date_str}, #{rec.source}, #{rec.traffic_rating_id}, #{rec.rating}"
    #   # puts "#{rec.traffic_camera_id}, #{rec.latitude}, #{rec.longitude}, #{rec.report_date.localtime.strftime("%m/%d/%Y - %I:%M%p")},  #{rec.source}, #{rec.traffic_rating_id}, #{rec.rating}"
    # end
    # tz_offset = Map::TZ_Offset # (Time.zone.utc_offset / 3600).to_s << ":00"
    @alerts = TrafficCondition.current_conditions( Map::TZ_Offset )
    # respond_to do |format|
    #   format.html
    #   format.json {  
    # 
    # end 
  end

  def new
    @map = Map.new
    @map.radius_distance = Victoria::Application::RadiusDistance
  end
  
  def create
    @map = Map.new(params[:map])
    if @map.valid?
      if request.post?
        params[:map]['radius_distance'] = 5 if params[:map]['radius_distance'].blank?
        redirect_to maps_path(:search => params[:map]) # passing the params from the search form
      end
    else
      render :action => 'new'
    end
  end

  def zones
    # Map_Points_1.each do |point|
    #   nil
    # end
  end

  private
  
  def locations_coords
    coords = []
    @locations.each do |loc|
      coords.push("#{loc.address} #{loc.city} #{loc.state}" )
    end
    coords
  end
  
  # def get_search_conditions
  #   search = params[:search]
  #   cond_params = {
  #     # :retailer_category_id   => search[:retailer_category_id].to_i,
  #     # :retailer_name          => "%#{search[:retailer_name]}%",
  #     # :retailer_addr          => "%#{search[:retailer_addr]}%",
  #     :radius_distance        => search[:radius_distance].to_i,
  #     :beg_date               => Date.today.to_s,
  #     :end_date               => Date.today.to_s
  #   }
  #   # cond_params[:location_addr] = "'#{search[:location_addr]}'" unless search[:location_addr].blank?
  #   
  #   cond_strings = []
  #     # cond_strings << "retailers.retailer_category_id IN (#{cond_params[:retailer_category_id]})" unless search[:retailer_category_id].blank?
  #     # cond_strings << "retailers.name LIKE :retailer_name"                        unless search[:retailer_name].blank?
  #     # cond_strings << "retailers.address LIKE :retailer_addr"                     unless search[:retailer_addr].blank?
  #     # cond_strings << "1 = 1"
  #     cond_strings << "(deals.beg_date <= '#{Date.today.to_s}' AND deals.end_date >= '#{Date.today.to_s}')"
  #     cond_strings << "deals.active_flag = 1"
  #   cond_strings.any? ? [ cond_strings.join(' AND '), cond_params ] : nil
  #   # NOTE: a default value for params[:map]['radius_distance'] was set in the "create" method so it will always have a value
  # end
  
end

  # def miles_to_km( in_miles )
  #   (1628352 / 1000000.to_f) * in_miles
  # end
  # 
  # def km_to_miles( in_kilometers )
  #   (1000000 / 1628352.to_f) * in_kilometers
  # end
  
  def choose_layout    
    if [ 'index', 'new', 'create','zones' ].include? action_name
      'application'
    else
      'application'
    end
  end

  # def basic
  #   @coords = "41.596, -82.71" # Kelleys Island
  #   respond_to do |format|
  #     format.html # basic.html.erb
  #   end  
  # end

  # def points
  #   @locations = Retailer.has_lat_long.includes(:deals, :advertisements)
  # end
  
  # def overlays
  #   @coords = "41.596, -82.71"
  # end
  
  # def infowindow_simple
  #   @coords = "41.596, -82.71" # Kelleys Island
  #   # @content_string = "Content Here"
  #   @content_string = 
  #    '<div id="content">' << "#{@coords}" << '</div>'
  #    
  #     #   This is the content string</div>
  #     # <div id="siteNotice"></div>
  #     # <h1 id="firstHeading" class="firstHeading">Uluru</h1>'
  # end
=begin
# look up coordinates of some location (like searching Google Maps)
Geocoder.coordinates("25 Main St, Cooperstown, NY")
 => [42.700149, -74.922767]

# distance (in miles) between Eiffel Tower and Empire State Building
Geocoder::Calculations.distance_between([47.858205,2.294359], [40.748433,-73.985655])
 => 3619.77359999382

# find the geographic center (aka center of gravity) of objects or points
Geocoder::Calculations.geographic_center([city1, city2, [40.22,-73.99], city4])
 => [35.14968, -90.048929]
 
from Cascade: ["devices.name LIKE :name AND customers.name LIKE :customer", {:name=>"%Kel%", :account=>"%%", :customer=>"%San%", :location_name=>"%%", :imei=>"%%", :wireless_provider=>"%%", :timezone=>"%%"}] 
["retailers.name LIKE :name", {:name=>"%Kel%", :account=>"%%", :customer=>"%San%", :location_name=>"%%", :imei=>"%%", :wireless_provider=>"%%", :timezone=>"%%"}]
 
=end

=begin
SELECT 
  `retailers`.`id` AS t0_r0, 
  `retailers`.`name` AS t0_r1, 
  `retailers`.`address` AS t0_r2, 
  `deals`.`id` AS t1_r0, 
  `deals`.`deal_type_id` AS t1_r1, 
  `deals`.`retailer_id` AS t1_r2, 
  `deals`.`advertiser_id` AS t1_r3, 
  `deals`.`name` AS deal_name, 
  `deals`.`beg_date` AS cp_beg, 
  `deals`.`end_date` AS cp_end, 
  `advertisements`.`id` AS t2_r0, 
  `advertisements`.`retailer_id` AS t2_r1, 
  `advertisements`.`advertiser_id` AS t2_r2, 
  `advertisements`.`name` AS ad_name,
  `advertisements`.`beg_date` AS ad_beg, 
  `advertisements`.`end_date` AS ad_end
FROM `retailers` 
LEFT OUTER JOIN `deals` ON `deals`.`retailer_id` = `retailers`.`id` 
LEFT OUTER JOIN `advertisements` ON `advertisements`.`retailer_id` = `retailers`.`id` 
WHERE 
  `retailers`.`id` IN (8) AND 
  (latitude IS NOT NULL AND longitude IS NOT NULL) AND 
  (retailers.retailer_category_id IN (6) AND 
  ((deals.beg_date <= '2011-11-29' AND deals.end_date >= '2011-11-29') 
    OR 
  (advertisements.beg_date <= '2011-11-29' AND advertisements.end_date >= '2011-11-29')))

SELECT 
  `retailers`.`id` AS t0_r0, 
  `retailers`.`name` AS t0_r1, 
  `retailers`.`address` AS t0_r2, 
  `retailers`.`city` AS t0_r3, 
  `retailers`.`state` AS t0_r4, 
  `retailers`.`zip` AS t0_r5, 
  `retailers`.`phone` AS t0_r6, 
  `retailers`.`contact_name` AS t0_r7, 
  `retailers`.`contact_email` AS t0_r8, 
  `retailers`.`created_at` AS t0_r9, 
  `retailers`.`updated_at` AS t0_r10, 
  `retailers`.`latitude` AS t0_r11, 
  `retailers`.`longitude` AS t0_r12, 
  `retailers`.`retailer_category_id` AS t0_r13, 
  `deals`.`id` AS t1_r0, 
  `deals`.`deal_type_id` AS t1_r1, 
  `deals`.`retailer_id` AS t1_r2, 
  `deals`.`advertiser_id` AS t1_r3, 
  `deals`.`name` AS t1_r4, 
  `deals`.`description` AS t1_r5, 
  `deals`.`content` AS t1_r6, 
  `deals`.`beg_date` AS t1_r7, 
  `deals`.`end_date` AS t1_r8, 
  `deals`.`created_at` AS t1_r9, 
  `deals`.`updated_at` AS t1_r10, 
  `advertisements`.`id` AS t2_r0, 
  `advertisements`.`retailer_id` AS t2_r1, 
  `advertisements`.`advertiser_id` AS t2_r2, 
  `advertisements`.`advertisement_type_id` AS t2_r3, 
  `advertisements`.`name` AS t2_r4, 
  `advertisements`.`description` AS t2_r5, 
  `advertisements`.`content` AS t2_r6, 
  `advertisements`.`beg_date` AS t2_r7, 
  `advertisements`.`end_date` AS t2_r8, 
  `advertisements`.`created_at` AS t2_r9, 
  `advertisements`.`updated_at` AS t2_r10 
FROM `retailers` 
LEFT OUTER JOIN `deals` ON `deals`.`retailer_id` = `retailers`.`id` 
LEFT OUTER JOIN `advertisements` ON `advertisements`.`retailer_id` = `retailers`.`id` 
WHERE 
  `retailers`.`id` IN (8) AND 
  (latitude IS NOT NULL AND longitude IS NOT NULL) AND 
  (retailers.retailer_category_id IN (6) AND 
  ((deals.beg_date <= '2011-11-29' AND deals.end_date >= '2011-11-29') 
    OR 
  (advertisements.beg_date <= '2011-11-29' AND advertisements.end_date >= '2011-11-29')))
  
  # if cond_params[:location_addr]
  # # if cond_params[:location_addr]
  #   @locations = Retailer.has_lat_long.where(search_conditions).includes(:deals).near(cond_params[:location_addr], cond_params[:radius_distance], { :units => :km }) #.page(params[:page]).per(10)
  # else
  #   @locations = Retailer.has_lat_long.where(search_conditions).includes(:deals) #.page(params[:page]).per(10)
  # end
  # if !params[:search]['location_addr'].blank? # if a location address was provided, center the map on that location
  #   @center_lat_lng = Geocoder.coordinates(params[:search]['location_addr'])  
  # elsif @locations.any? # if there were locations, center the map on them (or it)
  #   @center_lat_lng = Geocoder::Calculations.geographic_center(locations_coords) #([40.22,-73.99] or city])
  # else # if all else fails, center on this location
  #   @center_lat_lng = Geocoder.coordinates("Guatemala City, Guatemala")
  # end

=end
  
  
  
  
  
  