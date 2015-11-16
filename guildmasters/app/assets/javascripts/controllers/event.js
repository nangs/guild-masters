GM.EventController = Ember.Controller.extend();

GM.EventController.filter = function (events){
	events = events.filter(function(e) {
		return e.quest.state == 'assigned';
	});
	events.sort(function(event1, event2) {
		return event1.end_time - event2.end_time;
	});
	return events
}

GM.EventController.getAllEvents = function () {
	$.ajax({
		type: 'GET',
	    url: 'events.json',
	    success: function(data) {
	    	GM.EventController.event_list = GM.EventController.filter(data);
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
	    	console.log('here');
	    	console.log(data);
	    	showView();
	    }
	});
	GM.EventController.getAllEvents();
	GM.AdventurerController.getAllAdventurers();
	GM.QuestController.getAllQuests();
}
GM.EventController.getAllEvents();
