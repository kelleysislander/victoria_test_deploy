module RetailersHelper

  def is_geocoded?( lat, lng )
    if lat && lng then "Y" else "N" end
  end
  
end
