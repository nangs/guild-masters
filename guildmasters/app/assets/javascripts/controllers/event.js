GM.EventController = Ember.Controller.extend();

GM.EventController.getAllEvents = function () {
	$.ajax({
		type: 'GET',
	    url: 'events.json',
	    success: function(data) {
	    	GM.EventController.event_list = data;
	    	GM.nextEvent = GM.EventController.event_list[0];
	    }
	});
}


GM.EventController.getAllEvents();
