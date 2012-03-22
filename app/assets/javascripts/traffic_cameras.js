// sends in the value of traffic_condition_traffic_data_type_id from the traffic_condition form


function hide_or_show_traffic_camera( opt_val ) {

  if ( opt_val == 0 ) { // do not geocode by address, latitude and longitude are required

	  $('#traffic_camera_address').hide() 							// not required
	  $('#address_label').hide() 												// not required
	  	
	  $('#traffic_camera_latitude').show() 							// required
	  $('#latitude_label').show() 											// required
	  	
	  $('#traffic_camera_longitude').show() 						// required
	  $('#longitude_label').show() 											// required

	}
	else if ( opt_val == 1 ) { // do geocode by address, latitude and longitude are not required
	
	  $('#traffic_camera_address').show() 							// required
	  $('#address_label').show() 												// required
	  	
	  $('#traffic_camera_latitude').hide() 							// not required
	  $('#latitude_label').hide() 											// not required
	  	
	  $('#traffic_camera_longitude').hide() 						// not required
	  $('#longitude_label').hide() 											// not required

	}
}

function hide_fields() {
	
  $('#traffic_camera_address').hide()  
  $('#address_label').hide() 					 
  	                                   
  $('#traffic_camera_latitude').hide() 
  $('#latitude_label').hide() 				 
  	                                   
  $('#traffic_camera_longitude').hide()
  $('#longitude_label').hide() 				 
                                       
}
// inspired by: http://stackoverflow.com/questions/2921745/how-to-make-cross-domain-ajax-calls-to-google-maps-api
function geocode_address( address_in ) {
  var geocoder = new google.maps.Geocoder();
  // var address = address_in;

  if (geocoder) {
    geocoder.geocode({ 'address': address_in }, function (results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        // alert(results[0].geometry.location)
        var latlng = results[0].geometry.location.toString();
        // ie. (41.5969932, -82.71018229999999); for kelleys island, oh
        var latlng = latlng.substr(1, latlng.length - 2);
        var lat = latlng.substr(0, latlng.indexOf(","));
        var lng = latlng.substr(latlng.indexOf(",") + 2, latlng.length - 2);
        $('#traffic_camera_latitude').val(lat);
        $('#traffic_camera_longitude').val(lng);
        // address = $('#traffic_condition_other_address').val();
        $('#geocode_results').empty();
        $('#geocode_results').append($("<div><b>Latitude / Longitude coordinates successfully acquired for '" + address_in + "'</b></div>"));
        // $('#geocode_results').text("Geocode Successful");
        // console.log(results[0].geometry.location);
      }
      else {
        // alert("Geocoding failed: " + status)
        alert("ERROR: Latitude / Longitude coordinates were not acquired: " + status)
        $('#traffic_camera_latitude').val(null)
        $('#traffic_camera_longitude').val(null)
        $('#geocode_results').empty();
        // console.log("Geocoding failed: " + status);
      }
    });
  }    
} // function geocode_address()
