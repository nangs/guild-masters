GM.Event = DS.Model.extend({
	startTime: DS.attr('number'),
	endTime: DS.attr('number'),
	goldSpent: DS.attr('number')
});

GM.EventModel = DS.Model.extend();

GM.EventModel.filter = function (events){
	events = events.filter(function(e) {
		return e.quest.state == 'assigned';
	});
	events.sort(function(event1, event2) {
		return event1.end_time - event2.end_time;
	});
	return events
}

GM.EventModel.getNextEvent = function (func) {
	$.ajax({
		type: 'GET',
	    url: 'events.json',
	    success: function(data) {
	    	GM.EventModel.event_list = GM.EventModel.filter(data);
	    	GM.nextEvent = GM.EventModel.event_list[0];
	    	func(GM.nextEvent);
	    }
	});
}

GM.EventModel.getAllEvents = function (func) {
	$.ajax({
		type: 'GET',
	    url: 'events.json',
	    success: function(data) {
	    	GM.EventModel.event_list = GM.EventModel.filter(data);
	    	GM.nextEvent = GM.EventModel.event_list[0];
	    	func(GM.event_list);
	    }
	});
}

GM.EventModel.complete = function (id) {
	$.ajax({
		type: 'POST',
	    url: 'events.json',
	    data :{
	    	cmd: 'complete',
	    	eventId: id
	    },
	    success: function(data) {
	    	showView(data);
			GM.QuestModel.getAllQuests();
			GM.AdventurerModel.getAllAdventurers();
			GM.EventModel.getAllEvents();
	    },
	});
}