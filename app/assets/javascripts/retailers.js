// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

// inspired by: http://stackoverflow.com/questions/2921745/how-to-make-cross-domain-ajax-calls-to-google-maps-api

function get_address() {
	address = $('#retailer_address').val() + ", " + $('#retailer_city').val() + ", " + $('#retailer_state').val();
	// address = $('#retailer_address').val() + ", " + $('#retailer_city').val() + ", " + $('#retailer_state').val() + ", " + $('#retailer_zip').val();
	return address;
}

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
        $('#retailer_latitude').val(lat);
        $('#retailer_longitude').val(lng);
        // address = $('#traffic_condition_other_address').val();
        $('#geocode_results').empty();
        $('#geocode_results').append($("<div><b>Latitude / Longitude coordinates successfully acquired for '" + address_in + "'</b></div>"));
        // $('#geocode_results').text("Geocode Successful");
        // console.log(results[0].geometry.location);
      }
      else {
        // alert("Geocoding failed: " + status)
        alert("ERROR: Latitude / Longitude coordinates were not acquired: " + status)
        $('#retailer_latitude').val(null)
        $('#retailer_longitude').val(null)
        $('#geocode_results').empty();
        // console.log("Geocoding failed: " + status);
      }
    });
  }    
} // function geocode_address()
