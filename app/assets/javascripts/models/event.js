GM.Event = DS.Model.extend({
	startTime: DS.attr('number'),
	endTime: DS.attr('number'),
	goldSpent: DS.attr('number')
});

GM.EventModel = DS.Model.extend();

/**
 * get all the events from the database
 * @param  {function} func apply this input function to the events
 * @return {void}     
 */
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

/**
 * complete the next event
 * @return {void}     
 */
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

/**
 * Complete all the event up to the given time
 * @param  {string} a string representation of the game time
 * @return {void}     
 */
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
