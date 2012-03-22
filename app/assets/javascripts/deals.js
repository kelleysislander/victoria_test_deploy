function hide_or_show_deal( skeleton_flag, featured_flag ) {

  if ( skeleton_flag == 1 ) {
	
		$('#common').show();
		$('#required').hide();
		$('#dates').show();
		$('#featured').hide();
		
	}
	else {
	
		$('#common').show();
		$('#required').show()
		$('#dates').show();
		
		if ( featured_flag == 1 ) {
			$('#featured').show();
		} else {
			$('#featured').hide();
		}
	}
}
