// sends in the value of traffic_condition_traffic_data_type_id from the traffic_condition form


function hide_or_show_traffic_condition( opt_val ) {

  if ( opt_val == "LiveCam" || opt_val == "Historical" ) {

	  $('#traffic_condition_compass_point_id').hide() 	// not required
	  $('#compass_point_label').hide() 									// not required
	
	  $('#traffic_condition_traffic_camera_id').show() 	// required
	  $('#traffic_camera_id_label').show() 							// required
	
	  $('#traffic_condition_other_source').hide() 			// not required
	  $('#other_source_label').hide() 									// not required
	
	  $('#traffic_condition_other_address').hide() 			// not required
	  $('#other_address_label').hide() 									// not required
	
	  $('#traffic_condition_other_description').hide() 	// not required 
	  $('#other_description_label').hide() 							// not required 
	}
	else if ( opt_val == "Other:Other" ) {
	
	  $('#traffic_condition_traffic_camera_id').hide() 	// not required
	  $('#traffic_camera_id_label').hide() 							// not required
	
	  $('#traffic_condition_compass_point_id').show() 	// required
	  $('#compass_point_label').show() 									// required
	
	  $('#traffic_condition_other_source').show() 			// required
	  $('#other_source_label').show() 									// required

	  $('#traffic_condition_other_address').show() 			// required
	  $('#other_address_label').show() 									// required

	  $('#traffic_condition_other_description').show() 	// required
	  $('#other_description_label').show() 							// required
	}
  else if ( opt_val.indexOf('Other') == 0 && opt_val != "Other:Other" ) {

	  $('#traffic_condition_traffic_camera_id').hide() 	// not required
	  $('#traffic_camera_id_label').hide() 							// not required

	  $('#traffic_condition_compass_point_id').show() 	// required
	  $('#compass_point_label').show() 									// required
	
	  $('#traffic_condition_other_source').hide() 			// not required
	  $('#other_source_label').hide() 									// not required

	  $('#traffic_condition_other_address').show() 			// required
	  $('#other_address_label').show() 									// required

	  $('#traffic_condition_other_description').show() 	// required
	  $('#other_description_label').show() 							// required
	}
}

// inspired by: http://stackoverflow.com/questions/2921745/how-to-make-cross-domain-ajax-calls-to-google-maps-api
function geocode_other_address( address_in ) {
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
        $('#traffic_condition_other_latitude').val(lat);
        $('#traffic_condition_other_longitude').val(lng);
        // address = $('#traffic_condition_other_address').val();
        $('#geocode_results').empty();
        $('#geocode_results').append($("<div><b>Latitude / Longitude coordinates successfully acquired for '" + address_in + "'</b></div>"));
        // $('#geocode_results').text("Geocode Successful");
        // console.log(results[0].geometry.location);
      }
      else {
        // alert("Geocoding failed: " + status)
        alert("ERROR: Latitude / Longitude coordinates were not acquired: " + status)
        $('#traffic_condition_other_latitude').val(null)
        $('#traffic_condition_other_longitude').val(null)
        $('#geocode_results').empty();
        // console.log("Geocoding failed: " + status);
      }
    });
  }    
} // function geocode_other_address()
