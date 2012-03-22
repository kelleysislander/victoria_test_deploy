// sends in the value of advertisement_type from the advertisement form


function hide_or_show_url( opt_text ) {

  if ( opt_text == "Splash" ) { // show "url"
		
	  $('#advertisement_url').show() 							// required
	  $('#url_label').show() 											// required
	  	
	}
	else { // hide "url"
	
	  $('#advertisement_url').hide() 							// not required
	  $('#url_label').hide() 											// not required
	  	
	}
}

function hide_fields() {
  $('#advertisement_url').hide() 							// not required
  $('#url_label').hide() 											// not required
                                       
}
