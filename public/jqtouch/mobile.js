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

var app = {
  username: "", 
  password: "",
  logged_in: false,
  login:function ($form) {
    jQuery.ajax({
      type:$form.attr("method"), url:$form.attr("action"),
      dataType:"json", data:$form.serialize(),
      complete:function (req) {
        if (req.status === 200 || req.status === 304) {
          jQT.goBack();
        } else {
          alert("There was an error logging in. Try again.");
          jQT.goBack();
        }
      }
    });    
    
    return false;
  }
};

function getLocations(e, info)  {

	// Bind to the page animatoin end. Page tag in index.html
	    if ( (info) && (info.direction === "out") ) {
	      return;
	    }

 	    var $page = jQuery(this);
	    if ($page.data("lded")) {
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
			   // $ul.append("<li class='arrow' id='" + this.woeid + "'><a href='#topics'>" + this.name +  " (" + this.placeType.name + ")<small>" + curr_hour + ":" + curr_min + ":" + curr_sec + "</small>" + "</a></li>");
//			   $ul.append("<li class='arrow' id='8888'><a id='9999' href='#topics'>" + this.name +  " (" + this.placeType.name + ")<small>" + curr_hour + ":" + curr_min + ":" + curr_sec + "</small>" + "</a></li>");
			   $ul.append("<li class='arrow'><a href='/topics?woeid=" + this.woeid + "'>" + this.name +  " (" + this.placeType.name + ")<small>" + curr_hour + ":" + curr_min + ":" + curr_sec + "</small>" + "</a></li>");
			
		 	});
		    $ul.append("<li class='arrow'><a href=\"/dlists\">Dynamic Lists</a></li>");
		    $ul.append("<li class='arrow'><a href='#more'>List 3</a></li>");
	      } // success: function
		  }); //jQuery.ajax
	      $page.data("loaded", true);
	    // alert("Animating #month " + info.direction);	
} //getLists

function getTopics(e, info)  {

	// Bind to the page animatoin end. Page tag in index.html
	    if ( (info) && (info.direction === "out") ) {
	      return;
	    }

		jQuery.ajax({
		  url: "/topics.json",
		  dataType: 'json',
		  error: function(data) {
			alert('error');
		  },
		  success: function(data) {
			var d = new Date();

			var curr_hour = d.getHours();
			var curr_min = d.getMinutes();
			var curr_sec = d.getSeconds();

			var $ul = jQuery("#topics ul");
			$ul.empty();
			jQuery.each(data[0].trends, function() {
			   $ul.append("<li>" + this.name + "<small>" + curr_hour + ":" + curr_min + ":" + curr_sec + "</small>" + "</li>");
			
		 	});
	      } // success: function
		  }); //jQuery.ajax
	    // alert("Animating #month " + info.direction);	
} //getLists

jQuery(document).ready(function () { // Execute this when the DOM is ready
  // Add custom handler code here.


  jQuery("#refresh").bind("click", function(e) {
       //$("#Container").load("index.html");
	   getLocations(e);
      });


  jQuery("#tlc").bind("click", function(e) {
	   alert("locations");
      });


  jQuery("#locations").bind("pageAnimationEnd", function (e, info) { // Bind to the page animatoin end. Page tag in index.html
      getLocations(e, info);
  }); // pageAnimationEnd

  jQuery("#topics").bind("pageAnimationEnd", function (e, info) { // Bind to the page animatoin end. Page tag in index.html
      getTopics(e, info);
  }); // pageAnimationEnd

  // This handles the "login" button
  jQuery("#login a.login").tap(function (e) { // under id login, find all anchor (a) tags with class of login
    var $form = jQuery(this).closest("form");
	app.username = jQuery('#uname').val();
	app.password = jQuery('#passwd').val();
	alert(app.username);
	alert(app.password);
    return app.login($form);
  });
  
  // this handles clicking the "go" button  
  jQuery("#login").submit(function (e) {
    var $form = jQuery(this);
	app.username = jQuery('#uname').val();
	app.password = jQuery('#passwd').val();
	alert(app.username);
	alert(app.password);
    return app.login($form);
  });

}); //DOM Ready
