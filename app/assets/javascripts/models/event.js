GM.Event = DS.Model.extend({
	startTime: DS.attr('number'),
	endTime: DS.attr('number'),
	goldSpent: DS.attr('number')
});

GM.EventModel = DS.Model.extend();


GM.EventModel.getAllEvents = function (func) {
	$.ajax({
		type: 'POST',
	    url: 'events.json',
	    data: {
	    	cmd: 'get'
	    },
	    statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(data) {
	    	var gameTime = GM.GuildmasterModel.guildmaster.game_time;
	    	GM.EventModel.event_list = GM.EventController.filterFuture(data.events, gameTime);
	    	GM.EventModel.nextEvent = GM.EventModel.event_list[0];
	    	func(GM.EventModel.event_list);
	    }
	});
}

GM.EventModel.completeNextEvent = function () {
	$.ajax({
		type: 'POST',
	    url: 'events.json',
	    data :{
	    	cmd: 'complete_next',
	    },
	    statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(data) {
	    	console.log(data);
	    	GM.EventController.showEventResults(data.events);
	    	GM.EventModel.getAllEvents(setupTimeBar);
	    },
	});
}

GM.EventModel.completeEventsUntil = function (time) {
	$.ajax({
		type: 'POST',
	    url: 'events.json',
	    data :{
	    	cmd: 'complete',
	    	end_time: time
	    },
	    statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(data) {
	    	console.log(data);
	    	GM.EventController.showEventResults(data);
	    	GM.EventModel.getAllEvents(setupTimeBar);
	    	GM.GuildmasterModel.getGuildmaster();
	    },
	});
}
