var jQT = new jQuery.jQTouch({
  icon:'quickview_for_android_icon.png',
  //addGlossToIcon: false,
  startupScreen:"ctctlogo.png",
  statusBar:'black-translucent',
  preloadImages:[
    '/jqtouch/themes/jqt/img/back_button.png',
    '/jqtouch/themes/jqt/img/back_button_clicked.png',
    '/jqtouch/themes/jqt/img/button_clicked.png',
    '/jqtouch/themes/jqt/img/grayButton.png',
    '/jqtouch/themes/jqt/img/whiteButton.png',
    '/jqtouch/themes/jqt/img/loading.gif'
  ]
});

function getLocations(e, info)  {
	// Bind to the page animation end. Page tag in index.html
		if ( (info) && (info.direction === "out") ) {
	      return;
	    }

 	    var $page = jQuery(this);
	    if ($page.data("loaded")) {
	      return;
	    }

		jQuery.ajax({
		  url: "/locations.json",
		  dataType: 'json',
		  success: function(data) {
			var d = new Date();
			var curr_hour = d.getHours();
			var curr_min = d.getMinutes();
			var curr_sec = d.getSeconds();

			var $ul = jQuery("#locations ul");
			$ul.empty();
			jQuery.each(data, function() {
			   $ul.append("<li class='arrow'><a href='/topics?woeid=" + this.woeid + "&place=" + this.name + "'>" + this.name +  " (" + this.placeType.name + ")<small>" + curr_hour + ":" + curr_min + ":" + curr_sec + "</small>" + "</a></li>");
		 	});
			$ul.append("<li>Last updated at " + curr_hour + ":" + curr_min + ":" + curr_sec + "</li>");
	      } // success: function
		  }); //jQuery.ajax
	      $page.data("loaded", true);
} //getLocations


jQuery(document).ready(function () { // Execute this when the DOM is ready

  jQuery("#refresh").bind("click", function(e) {
		var $page = jQuery(this);
		$page.data("loaded", false);
	   getLocations(e);
      });

  jQuery("#locations").bind("pageAnimationEnd", function (e, info) { // Bind to the page animatoin end. Page tag in index.html
      getLocations(e, info);
  }); // pageAnimationEnd

  jQuery("#topics").bind("pageAnimationEnd", function (e, info) { // Bind to the page animatoin end. Page tag in index.html
      getTopics(e, info);
	  alert("Topics Animation end!")
  }); // pageAnimationEnd

}); //DOM Ready
