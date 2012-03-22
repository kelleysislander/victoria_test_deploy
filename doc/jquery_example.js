// Example jQuery AJAX calls
// Use .livequery for elements that do not yet exist and won't be triggered by a click event.
// Use .live for elements that do not yet exist but will be triggered by an eventual click event.
// Use the Function Extend method below for adding custom functions you want to be able to call from any DOM element.
// Use the alternative method for non global functions (see *********** below)

$.fn.extend({
    ajaxify_link_form_and_update_screen_target_with_result: function(target_selector) {
        return this.livequery('click',
        function() {
            $(this).parent('form').ajaxSubmit(function(data) {
                $(target_selector).replaceWith(data);
            });
            return false;
        });
    },

    ajaxify_links_and_update_screen_with_result: function(options) {
        return this.live('click',
        function() {
					options = (options || {});
					if(options.link_sel){
						$link = $(this).find(options.link_sel);
					}else{
						$link = $(this);
					}
					$.get($link.attr('href'),
            function(data) {
                if (options.success) {
                    options.success.call(data);
                }
            });
            return false;
        });
    }
});

# Example call for above
$('#some-div form a.some-link').ajaxify_link_form_and_update_screen_target_with_result('#some_target');

$('div#some-div a.some-link').ajaxify_links_and_update_screen_with_result(
{
    success: function(data) {
        $('.some-class:first div#some-div').html(data);
    }
}
);

# *************************************************
# Use this method of adding custom functions for things that are not going to be called from multiple DOM elements.
$(function() {

	function doSomething(selector) {
		var info = $(selector).val().split('|');
		# Do some other stuff
		return false;
	}

});

# Example call for above
#some-div.find('#some-other-div').change(function(){
	doSomething($(this));
}).end()

