module TrafficCamerasHelper
  
  def status( in_val )
    TrafficCamera::StatusFlags.each do |val, idx|
      return val if idx == in_val 
    end
  end
  
  def geocode( in_val )
    TrafficCamera::GeocodeFlags.each do |val, idx|
      return val if idx == in_val 
    end
  end
end
