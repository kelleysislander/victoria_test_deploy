$(function(){
$('input.date_picker').livequery(function() {
    $(this).attr('readonly','readonly')
			.datepicker({
        dateFormat: 'd M yy',
        changeMonth: true,
        numberOfMonths: 1,
        beforeShow: function(){
					var opposite = $(this).hasClass('start_date') ? $("input.date_picker.end_date") : $("input.date_picker.start_date");
					var opposite_has_val = opposite.val() != '';
					var oppositeDate = opposite.length == 0 ? new Date() : new Date(opposite.val());
						
					var options = {};
		      if ( $(this).hasClass('start_date') && opposite_has_val ) options.maxDate = oppositeDate;
		      if ( $(this).hasClass('end_date') && opposite_has_val ) options.minDate = oppositeDate;
		      if ( $(this).hasClass('no_past') ) options.minDate = oppositeDate;

		      return options;	
				}
	});
});
});