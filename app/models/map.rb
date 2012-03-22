class Map # a virtual model used as a container for the SQL and search logic
  
  include ActionView::Helpers::TextHelper # for "pluralize"
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :retailer_name, :retailer_addr, :retailer_category_id, :advertiser_name, :radius_distance, :location_addr, :current_lat, :current_lng
  
  # RadiusDistance = Array.new(20) {|i| Array.new.push("#{i+1} miles",i+1)} # for "radius_distance" selectbox options
  RadiusDistances = Array.new(20) {|i| Array.new.push("#{i+1} #{(i+1 == 1 ? 'kilometer' : 'kilometers')}",i+1)}
  TZ_Offset = (Time.zone.utc_offset / 3600).to_s << ":00"
  
  validates_length_of :retailer_name,         :within => 3..50, :unless => lambda{ |obj| obj.retailer_name.blank? }
  validates_length_of :retailer_addr,         :within => 5..80, :unless => lambda{ |obj| obj.retailer_addr.blank? }

  validates_length_of       :location_addr,   :within => 5..80, :unless => lambda{ |obj| obj.location_addr.blank? }
  validates_presence_of     :radius_distance,                   :unless => lambda{ |obj| obj.location_addr.blank? }
  validates_numericality_of :radius_distance,                   :unless => lambda{ |obj| obj.location_addr.blank? }

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false    
  end

  def self.search
    Retailer.all
  end
  
=begin
  self[0] is the first point in the polygon, self[1] is the second, and so on. 
  Also, point.x gives you the x value of the point. 
  Oh, and self.size returns the number of points in the polygon
  "point" is the x,y coordinate to test existence within the polygon
  "polygon_points" is an array of (x,y) coords in longitude, latitude order that defines the polygon
  Map_Points_in_Polygon_Zone_1, below, is an example

  Zone 1 Mixco                    14.63200,  -90.599785
  Zone 2 5A Calle @ 15            14.649273, -90.499535
  Zone 3 Club de Golf San Isidro  14.598778, -90.471725
  Not in a zone                   32.8575,   -96.7558
  
  Using reversed coordinates so that x = longitude and y = latitude
  point = [14.63200,  -90.599785].reverse!
  Map.contains_point?( point , Map::Map_Points_in_Polygon_Zone_1 )
  point = [32.8575,  -96.7558].reverse!
  Map.contains_point?( point, Map::Map_Points_in_Polygon_Zone_1 )

  Using the "normal" latitude / longitude (x, y) coordinates
  point = [14.63200,  -90.599785]
  Map.contains_point?( point , Map::Polygon_Points_Zone_1 )
  point = [32.8575,  -96.7558]
  Map.contains_point?( point, Map::Polygon_Points_Zone_1 )
=end

  private

  X, Y = 0, 1

  Zones = [
    # Displayed     stored in DB
    [ "Not in a Zone",  0     ],
    [ "Zone 1",         1     ],
    [ "Zone 2",         2     ],
    [ "Zone 3",         3     ],
  ]
  Polygon_Points = {
    1  => [14.67,     -90.63],
    2  => [14.67,     -90.44],
    3  => [14.55,     -90.44],
    4  => [14.55,     -90.63],
    5  => [14.67,     -90.54],
    6  => [14.658,    -90.540304],
    7  => [14.623292, -90.516658],
    8  => [14.622160, -90.517945],
    9  => [14.600528, -90.520949],
    10 => [14.600528, -90.535326],
    11 => [14.571705, -90.538909],
    12 => [14.55,     -90.543780],
    13 => [14.623908, -90.516014],
    14 => [14.623908, -90.483634],
    15 => [14.615769, -90.471103],
    16 => [14.602397, -90.465567],
    17 => [14.583168, -90.461683],
    18 => [14.583168, -90.44],
    19 => [14.583168, -90.482690],

    # 17 => [14.582587, -90.461683],
    # 18 => [14.582587, -90.44],
    # 19 => [14.582587, -90.482690],

    20 => [14.581922, -90.488613],
    21 => [14.579762, -90.497003],
    22 => [14.564561, -90.493355],
    23 => [14.55,     -90.484128],
  }
  # points that define the polygons used on the Guatemala map
  Polygon_Points_Zone_1 = [
    Polygon_Points[1],
    Polygon_Points[5],
    Polygon_Points[6],
    Polygon_Points[7],
    Polygon_Points[8],
    Polygon_Points[9],
    Polygon_Points[10],
    Polygon_Points[11],
    Polygon_Points[12],
    Polygon_Points[4],
    Polygon_Points[1],
  ]
  Polygon_Points_Zone_2 = [
    Polygon_Points[5],
    Polygon_Points[2],
    Polygon_Points[18],
    Polygon_Points[17],
    Polygon_Points[16],
    Polygon_Points[15],
    Polygon_Points[14],
    Polygon_Points[13],
    Polygon_Points[7],
    Polygon_Points[6],
    Polygon_Points[5]
  ]
  Polygon_Points_Zone_3 = [
    Polygon_Points[18],
    Polygon_Points[3],
    Polygon_Points[23],
    Polygon_Points[22],
    Polygon_Points[21],
    Polygon_Points[20],
    Polygon_Points[19],
    Polygon_Points[17],
    Polygon_Points[18]
  ]

  Polygon_Points_Zone_4 = [
    Polygon_Points[12],
    Polygon_Points[11],
    Polygon_Points[10],
    Polygon_Points[9],
    Polygon_Points[8],
    Polygon_Points[7],
    Polygon_Points[13],
    Polygon_Points[14],
    Polygon_Points[15],
    Polygon_Points[16],
    Polygon_Points[17],
    Polygon_Points[19],
    Polygon_Points[20],
    Polygon_Points[21],
    Polygon_Points[22],
    Polygon_Points[23],
    Polygon_Points[12]
  ]

  Polygon_Points_Border = [
    Polygon_Points[1],
    Polygon_Points[2],
    Polygon_Points[3],
    Polygon_Points[4],
    Polygon_Points[1]
  ]

=begin
  point = [14.63200,  -90.599785]
  Map.which_zone?( point )
  point = [32.8575,  -96.7558]
  Map.which_zone?( point )
  
  point = [32.8575,  -96.7558]
  zone = Map.which_zone?( point )
  if zone
    puts "Zone #{zone}" 
  else
    puts "No Zone"
  end
  
  point = [14.63200,  -90.599785]
  zone = Map.which_zone?( point )
  if zone
    puts "Zone #{zone}"
  else
    puts "No Zone"
  end

  point = [14.63200,  -90.599785]
  zone = Map.which_zone?( point )
  zone ||= 0

  point = [32.8575,  -96.7558]
  zone = Map.which_zone?( point )
  zone ||= 0

  point = [14.612,  -90.5338]
  zone = Map.which_zone?( point )
  zone ||= 0

=end

  def self.which_zone?( point )
    # loop through the 4 Polygon_Points_Zone_* arrays of points to see if the "point" is in any of them
    zone = nil
    # n = 0
    4.times.each_with_index do |n|
      polygon_points = eval("Polygon_Points_Zone_#{n + 1}")
      result = contains_point?( point, polygon_points )
      if result
        zone = n + 1
        break
      end
    end
    zone
  end
  
  # Inspired by: http://jakescruggs.blogspot.com/2009/07/point-inside-polygon-in-ruby.html
  def self.contains_point?( point, polygon_points )
    contains_point = false
    i = -1
    j = polygon_points.length - 1
    while (i += 1) < polygon_points.length
      a_point_on_polygon = polygon_points[i]
      trailing_point_on_polygon = polygon_points[j]
      if point_is_between_the_ys_of_the_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
        if ray_crosses_through_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
          contains_point = !contains_point
        end
      end
      j = i
    end
    return contains_point
  end

  def self.point_is_between_the_ys_of_the_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
    (a_point_on_polygon[Y] <= point[Y] && point[Y] < trailing_point_on_polygon[Y]) || 
    (trailing_point_on_polygon[Y] <= point[Y] && point[Y] < a_point_on_polygon[Y])
  end

  def self.ray_crosses_through_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
    (point[X] < (trailing_point_on_polygon[X] - a_point_on_polygon[X]) * (point[Y] - a_point_on_polygon[Y]) / (trailing_point_on_polygon[Y] - a_point_on_polygon[Y]) + a_point_on_polygon[X])
  end

end # class


=begin
def contains_point?(point)
  contains_point = false
  i = -1
  j = self.size - 1
  while (i += 1) < self.size
    a_point_on_polygon = self[i]
    trailing_point_on_polygon = self[j]
    if point_is_between_the_ys_of_the_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
      if ray_crosses_through_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
        contains_point = !contains_point
      end
    end
    j = i
  end
  return contains_point
end

private

def point_is_between_the_ys_of_the_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
  (a_point_on_polygon.y <= point.y && point.y < trailing_point_on_polygon.y) || 
  (trailing_point_on_polygon.y <= point.y && point.y < a_point_on_polygon.y)
end

def ray_crosses_through_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
  (point.x < (trailing_point_on_polygon.x - a_point_on_polygon.x) * (point.y - a_point_on_polygon.y) / 
             (trailing_point_on_polygon.y - a_point_on_polygon.y) + a_point_on_polygon.x)
end
=end  
  # scope :retailer_search, lambda{ |query| q = "%#{query.downcase}%"; { :conditions => ['lower(retailers.name) LIKE ?', q] } }


# NOTE: we are reversing these coords because the maps#contains_point? algorithm needs (x,y) coordinates which means (longitude, latitude) order
=begin
  Map_Points_in_Polygon_Zone_1 = []
  Map_Points_Zone_1.each_with_index do |point, idx|
    Map_Points_in_Polygon_Zone_1[ idx ] = point.reverse
  end

  Map_Points_in_Polygon_Zone_2 = []
  Map_Points_Zone_2.each_with_index do |point, idx|
    Map_Points_in_Polygon_Zone_2[ idx ] = point.reverse
  end

  Map_Points_in_Polygon_Zone_3 = []
  Map_Points_Zone_3.each_with_index do |point, idx|
    Map_Points_in_Polygon_Zone_3[ idx ] = point.reverse
  end
==end
=begin    
  var zone_1_coords = [
    // Zone 1, starting at upper left and moving clockwise
    new google.maps.LatLng(14.69, -90.67),
    new google.maps.LatLng(14.69, -90.59),
    new google.maps.LatLng(14.54, -90.534),
    new google.maps.LatLng(14.54, -90.67),
    new google.maps.LatLng(14.69, -90.67)
  ];
  var zone_2_coords = [
    // Zone 2, starting at upper left and moving clockwise
    new google.maps.LatLng(14.69, -90.59),
    new google.maps.LatLng(14.69, -90.44),
    new google.maps.LatLng(14.64, -90.44),
    new google.maps.LatLng(14.62, -90.56386225),
    new google.maps.LatLng(14.69, -90.59)
  ];
  var zone_3_coords = [
    // Zone 3, starting at upper left and moving clockwise
    new google.maps.LatLng(14.62, -90.56386225),
    new google.maps.LatLng(14.64, -90.44),
    new google.maps.LatLng(14.54, -90.44),
    new google.maps.LatLng(14.54, -90.534),
    new google.maps.LatLng(14.62, -90.56386225)
  ];

=end  

# class Map < Tableless
#   
#   belongs_to :retailers
#   
#   column :retailer_category_id, :integer
#   column :retailer_name, :string
#   column :advertiser_name, :string
#   column :retailer_addr, :string
#   column :location_addr, :string
#   column :radius_distance, :integer
#   
#   RadiusDistance = Array.new(10) {|i| Array.new.push("#{i+1} miles",i+1)} # for "radius_distance" selectbox options
#   
#   validates_length_of :retailer_name,         :within => 3..50, :unless => lambda{ |obj| obj.retailer_name.blank? }
#   validates_length_of :advertiser_name,       :within => 3..50, :unless => lambda{ |obj| obj.advertiser_name.blank? }
#   validates_length_of :retailer_addr,         :within => 5..80, :unless => lambda{ |obj| obj.retailer_addr.blank? }
#   
#   validates_length_of       :location_addr,   :within => 5..80, :unless => lambda{ |obj| obj.location_addr.blank? }
#   validates_presence_of     :radius_distance, :unless => lambda{ |obj| obj.location_addr.blank? }
#   validates_numericality_of :radius_distance, :unless => lambda{ |obj| obj.location_addr.blank? }
#   
#   scope :retailer_search, lambda{ |query| q = "%#{query.downcase}%"; { :conditions => ['lower(retailers.name) LIKE ?', "%dar%"] } }
#   
# end

# Original works except for "scope":


=begin 
  
  attr_accessor is ruby code and is used when you do not have a column in your database, but still want to show a field in your forms. 
  The only way to allow this is to attr_accessor :fieldname and you can use this field in your View, or model, if you wanted, but mostly in your View.

  attr_accessible allows you to list all the columns you want to allow Mass Assignment, as andy eluded to above. 
  The opposite of this is attr_protected which means this field i do NOT want anyone to be allowed to Mass Assign to. 
  More then likely it is going to be a field in your database that you don't want anyone monkeying around with. Like a status field, or the like.
  
  
  # named scopes for search filters
  
  scope :retailer_search, lambda{ |query| q = "%#{query.downcase}%"; { :conditions => ['lower(retailers.name) LIKE ?', q] } }
      
  # Map.scope :retailer_name_search, lambda { |query| q = "%#{query.downcase}"; { :conditions => [ 'lower(retailers.name) LIKE ?', q] } }

=end

=begin
  Polygon_Points_Zone_1 = [
    [14.67, -90.63],          # 1
    [14.67, -90.54],          # 5
    [14.658, -90.540304],     # 6
    [14.623292, -90.516658],  # 7
    [14.622160, -90.517945],  # 8
    [14.600528, -90.520949],  # 9
    [14.600528, -90.535326],  # 10
    [14.571705, -90.538909],  # 11
    [14.55, -90.543780],      # 12
    [14.55, -90.63],          # 4
    [14.67, -90.63]           # 1
  ]
  Polygon_Points_Zone_2 = [
    [14.67, -90.54],          # 5
    [14.67, -90.44],          # 2
    [14.582587, -90.44],      # 18
    [14.582587, -90.461683],  # 17
    [14.602397, -90.465567],  # 16
    [14.615769, -90.471103],  # 15
    [14.623908, -90.483634],  # 14
    [14.623908, -90.516014],  # 13
    [14.623292, -90.516658],  # 7
    [14.658, -90.540304],     # 6
    [14.67, -90.54]           # 5
  ]
  Polygon_Points_Zone_3 = [
    [14.582587, -90.44],      # 18
    [14.55, -90.44],          # 3
    [14.55, -90.484128],      # 23
    [14.564561, -90.493355],  # 22
    [14.579762, -90.497003],  # 21
    [14.581922, -90.488613],  # 20
    [14.582587, -90.482690],  # 19
    [14.582587, -90.461683],  # 17
    [14.582587, -90.44]       # 18
  ]
  Polygon_Points_Zone_4 = [
    [14.55, -90.543780],      # 12
    [14.571705, -90.538909],  # 11
    [14.600528, -90.535326],  # 10
    [14.600528, -90.520949],  # 9
    [14.622160, -90.517945],  # 8
    [14.623292, -90.516658],  # 7
    [14.623908, -90.516014],  # 13
    [14.623908, -90.483634],  # 14
    [14.615769, -90.471103],  # 15
    [14.602397, -90.465567],  # 16
    [14.582587, -90.461683],  # 17
    [14.582587, -90.482690],  # 19
    [14.581922, -90.488613],  # 20
    [14.579762, -90.497003],  # 21
    [14.564561, -90.493355],  # 22
    [14.55, -90.484128],      # 23
    [14.55, -90.543780]       # 12
  ]
=end

