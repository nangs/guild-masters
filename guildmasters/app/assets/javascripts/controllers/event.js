GM.EventController = Ember.Controller.extend();

GM.EventController.sort = function (events){
	events.sort(function(event1, event2) {
		return event1.end_time - event2.end_time;
	});	
}

GM.EventController.getAllEvents = function () {
	$.ajax({
		type: 'GET',
	    url: 'events.json',
	    success: function(data) {
	    	GM.EventController.event_list = data;
	    	GM.EventController.sort(GM.EventController.event_list);
	    	console.log(GM.EventController.event_list)
	    	GM.nextEvent = GM.EventController.event_list[0];
	    }
	});
}


GM.EventController.complete = function (id) {
	$.ajax({
		type: 'POST',
	    url: 'events.json',
	    data :{
	    	cmd: 'complete',
	    	eventId: id
	    },
	    success: function(data) {
	    	showView(data.responseText);
	    }
	});
}
GM.EventController.getAllEvents();
