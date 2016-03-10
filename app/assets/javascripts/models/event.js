GM.Event = DS.Model.extend({
	startTime: DS.attr('number'),
	endTime: DS.attr('number'),
	goldSpent: DS.attr('number')
});

GM.EventModel = DS.Model.extend();

GM.EventModel.filter = function (events){
	var gameTime = GM.GuildmasterModel.guildmaster.game_time;
	events = events.filter(function(e) {
		return e.end_time > gameTime;
	});
	events.sort(function(event1, event2) {
		return event1.end_time - event2.end_time;
	});
	return events;
}

GM.EventModel.getNextEvent = function (func) {
	$.ajax({
		type: 'GET',
	    url: 'events.json',
	    success: function(data) {
	    	GM.EventModel.event_list = GM.EventModel.filter(data);
	    	GM.EventModel.nextEvent = GM.EventModel.event_list[0];
	    	func(GM.nextEvent);
	    }
	});
}

GM.EventModel.getAllEvents = function (func) {
	$.ajax({
		type: 'GET',
	    url: 'events.json',
	    success: function(data) {
	    	GM.EventModel.event_list = GM.EventModel.filter(data.events);
	    	GM.EventModel.nextEvent = GM.EventModel.event_list[0];
	    	func(GM.EventModel.event_list);
	    }
	});
}

GM.EventModel.completeNextQuest = function (id) {
	$.ajax({
		type: 'POST',
	    url: 'events.json',
	    data :{
	    	cmd: 'complete_next',
	    },
	    success: function(data) {
	    	console.log(data);
	    	var questEvent = data.events[0];
	    	if (questEvent.msg == "success") {
	    		showView("The quest is completed.");
	    	} else {
	    		GM.EventController.questFailed(questEvent);
	    	}
	    	GM.EventModel.getAllEvents(setupTimeBar);
	    },
	});
}

GM.EventModel.completeNextFacilityEvent = function () {
	$.ajax({
		type: 'POST',
	    url: 'events.json',
	    data :{
	    	cmd: 'complete_next',
	    },
	    success: function(data) {
	    	console.log(data);
	    	if (data.events[0].msg == "success") {
	    		showView("The event is completed.");
	    	}
	    	GM.EventModel.getAllEvents(setupTimeBar);
	    },
	});
}
