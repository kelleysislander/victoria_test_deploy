class TrafficConditionsController < ApplicationController
  before_filter :authenticate_user!

  load_and_authorize_resource

  layout :choose_layout

  def index
    @traffic_conditions = nil # saves "load_and_authorize_resource" from doing an unnecessary query
    # @traffic_conditions = TrafficCondition.all
    # @others = TrafficCondition.includes(:traffic_data_type).where("traffic_data_type_id IN (6)")
    @others_types = TrafficDataType.other
    @others_types.each do |other|
      eval("@other_#{other.id} = TrafficCondition.where(:traffic_data_type_id => other.id).includes(:traffic_data_type, :traffic_camera, :traffic_rating, :compass_point).order(:report_date => :desc).limit(3)")
    end

    @cams = TrafficCamera.where(:status => 1).select("DISTINCT(id)")
    @cams.each do |cam|
      # conditions = TrafficCondition.where(:traffic_camera_id => cam.id).includes(:traffic_data_type, :traffic_camera, :traffic_rating, :compass_point).limit(3)
      # eval("@cam_#{cam.id} = TrafficCondition.where(:traffic_camera_id => cam.id).includes(:traffic_data_type, :traffic_camera, :traffic_rating, :compass_point, {:traffic_camera => :traffic_condition_historicals} ).order(:report_date => :desc).limit(3)")   
      eval("@cam_#{cam.id} = TrafficCondition.where(:traffic_camera_id => cam.id).includes(:traffic_data_type, :traffic_camera, :traffic_rating, :compass_point, {:traffic_camera => :traffic_condition_historicals} ).order('traffic_conditions.report_date desc').limit(3)")   
    end
    
  end

  def show
    # @traffic_condition = TrafficCondition.find(params[:id])
  end

  def new
    # @traffic_condition = TrafficCondition.new
    # NOTE: These "pre-select" the options for their respective selectbox objects on the form when clicking on the "Create" link on "traffic_cameras" index page
    if params[:traffic_data_type_id]
      @traffic_condition.traffic_data_type_id = params[:traffic_data_type_id] # sent in from "Create" link on "traffic_cameras" index page
    end
    if params[:traffic_camera_id]
      @traffic_condition.traffic_camera_id = params[:traffic_camera_id] # sent in from "Create" link on "traffic_cameras" index page
    end
    # traffic_condition_traffic_camera_id selectbox options
    # @traffic_cameras  = TrafficCamera.find(:all, :include => :compass_point).collect  { |tc| [ "#{tc.name} - #{tc.compass_point.name} - #{tc.address}", tc.id ] }
    # @traffic_ratings  = TrafficRating.find(:all).collect  { |tr| [ "#{tr.rating} - #{tr.description}", tr.id ] }
    # @compass_points   = CompassPoint.find(:all).collect   { |cp| [ "#{cp.name} - #{cp.description}", cp.id ] }
  end

  def create
    # @traffic_condition = TrafficCondition.new(params[:traffic_condition])
    if @traffic_condition.save
      @traffic_condition.update_attribute( :compass_point_id, @traffic_condition.traffic_camera.compass_point_id ) if @traffic_condition.traffic_camera
      redirect_to @traffic_condition, :notice => "Successfully created traffic condition."
    else
      if params[:traffic_condition]['traffic_data_type_id']
        @traffic_condition.traffic_data_type_id = params[:traffic_condition]['traffic_data_type_id'] # sent in from "Create" link on "traffic_cameras" index page
      end
      if params[:traffic_condition]['traffic_camera_id']
        @traffic_condition.traffic_camera_id = params[:traffic_condition]['traffic_camera_id'] # sent in from "Create" link on "traffic_cameras" index page
      end
      # @params = params
      render :action => 'new'
    end
  end

  def edit
    # @traffic_condition = TrafficCondition.find(params[:id])
  end

  def update
    # @traffic_condition = TrafficCondition.find(params[:id])
    if @traffic_condition.update_attributes(params[:traffic_condition])
      redirect_to @traffic_condition, :notice  => "Successfully updated traffic condition."
    else
      render :action => 'edit'
    end
  end

  def destroy
    # @traffic_condition = TrafficCondition.find(params[:id])
    @traffic_condition.destroy
    redirect_to traffic_conditions_url, :notice => "Successfully destroyed traffic condition."
  end
  
  private

  def test_populate_div
    @test = "billyK"
  end
  
  def test_populate_div_2
    @test = "billy"
  end

  def choose_layout    
    if [ 'test_populate_div' ].include? action_name
      'empty'
    else
      'traffic'
    end
  end
  
end

=begin
sql to get the 3 most recent recs per cam from "traffic_conditions", done by iterating over the set of cams and getting the recs from traffic_conditions
sql_str = ""

# Plan A
@cam_conditions = {}
@cams = TrafficCamera.where(:status => 1).select("DISTINCT(id)")
@cams.each do |cam|
  TrafficCondition.where(:traffic_camera_id => cam.id).limit(3).each do |condition|
    # puts "#{condition.traffic_camera_id}, #{condition.id}, #{condition.traffic_data_type_id}"
    key = "#{cam.id}_#{condition.id}"
    @cam_conditions[key] = condition
  end
  # puts "*******"
end

@cam_conditions.keys.each do |cond|
  puts cond
end

@cams.each do |cam|
  puts cam.id
end

@cam_conditions.each do |cond|
  key = cond[0]
  rec = cond[1]
  puts "key => #{key}, condition => #{rec[:report_date]}"
end

# Plan B, looking good so far, now to work out the display part
# create an instance var for each separate query
@cams = TrafficCamera.where(:status => 1).select("DISTINCT(id)")
@cams.each do |cam|
  # conditions = TrafficCondition.where(:traffic_camera_id => cam.id).includes(:traffic_data_type, :traffic_camera, :traffic_rating, :compass_point).limit(3)
  eval("@cam_#{cam.id} = TrafficCondition.where(:traffic_camera_id => cam.id).includes(:traffic_data_type, :traffic_camera, :traffic_rating, :compass_point).limit(3)") 
end

# for the view
@cams.each do |cam|
  eval("@cam_#{cam.id}").each do |cond|
    puts cond.id, cond.traffic_camera_id, cond.traffic_data_type.name, cond.traffic_camera.name
  end
end

#<TrafficCondition id: 1, traffic_data_type_id: 1, traffic_camera_id: 1, traffic_rating_id: 1, compass_point_id: 1, report_date: "2012-01-13 18:45:08", alert_message: nil, other_source: nil, other_description: nil, other_address: nil, other_latitude: nil, other_longitude: nil, created_at: "2012-01-16 13:57:03", updated_at: "2012-01-16 13:57:03">
#<TrafficCondition id: 2, traffic_data_type_id: 1, traffic_camera_id: 1, traffic_rating_id: 2, compass_point_id: 1, report_date: "2012-01-13 18:59:00", alert_message: nil, other_source: nil, other_description: nil, other_address: nil, other_latitude: nil, other_longitude: nil, created_at: "2012-01-16 13:57:03", updated_at: "2012-01-16 13:57:03">
#<TrafficCondition id: 3, traffic_data_type_id: 1, traffic_camera_id: 1, traffic_rating_id: 2, compass_point_id: 1, report_date: "2012-01-13 19:15:02", alert_message: nil, other_source: nil, other_description: nil, other_address: nil, other_latitude: nil, other_longitude: nil, created_at: "2012-01-16 13:57:03", updated_at: "2012-01-16 13:57:03">
#<TrafficCondition id: 6, traffic_data_type_id: 1, traffic_camera_id: 2, traffic_rating_id: 4, compass_point_id: 2, report_date: "2012-01-13 18:45:15", alert_message: nil, other_source: nil, other_description: nil, other_address: nil, other_latitude: nil, other_longitude: nil, created_at: "2012-01-16 13:57:11", updated_at: "2012-01-16 13:57:11">
#<TrafficCondition id: 7, traffic_data_type_id: 1, traffic_camera_id: 2, traffic_rating_id: 4, compass_point_id: 2, report_date: "2012-01-13 18:59:07", alert_message: nil, other_source: nil, other_description: nil, other_address: nil, other_latitude: nil, other_longitude: nil, created_at: "2012-01-16 13:57:11", updated_at: "2012-01-16 13:57:11">
#<TrafficCondition id: 8, traffic_data_type_id: 1, traffic_camera_id: 2, traffic_rating_id: 2, compass_point_id: 2, report_date: "2012-01-13 19:15:09", alert_message: nil, other_source: nil, other_description: nil, other_address: n
# cam_conditions.keys
# => ["1_1", "1_2", "1_3", "2_6", "2_7", "2_8", "3_11", "3_12", "4_18", "4_19", "4_20", "5_21", "5_22", "5_23", "6_26", "6_27", "6_28", "7_31", "7_32", "7_33", "8_36", "8_37", "8_38", "9_41", "9_42", "9_43", "10_46", "10_47", "10_48", "11_51", "11_52", "11_53", "12_56", "12_57", "12_58", "13_61", "13_62", "13_63", "14_66", "14_67", "14_68", "15_71", "15_72", "15_73", "16_76", "16_77", "16_78"]
# cam_conditions["1_1"]
# => #<TrafficCondition id: 1, traffic_data_type_id: 1, traffic_camera_id: 1, traffic_rating_id: 1, compass_point_id: 1, report_date: "2012-01-13 18:45:08", alert_message: nil, other_source: nil, other_description: nil, other_address: nil, other_latitude: nil, other_longitude: nil, created_at: "2012-01-16 13:57:03", updated_at: "2012-01-16 13:57:03">
tr.each do |rec|
  puts rec[0]
  puts "**********"
end
puts "tr => #{tr}

=end