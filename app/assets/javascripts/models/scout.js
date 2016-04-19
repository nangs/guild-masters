GM.ScoutModel = DS.Model.extend();

GM.ScoutModel.scout = function (time, gold) {
	$.ajax({
		type: 'POST',
	    url: 'events.json',
	    data : {
	    	cmd: 'create_scout_event',
	    	time_spent: time,
	    	gold_spent: gold
	    },
	    statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(data) {
	    	if (data.msg == 'success') {
	    		if (gold == 0) {
	    			showView('You are not spending any gold for this scouting.');
	    		} else {
	    			showView('You spent ' + gold + ' gold for this scouting.');
	    		}
	    		GM.GuildmasterModel.getGuildmaster();
	    		setupTimeBar();
	    	} else {
	    		GM.ScoutController.showMessage(data.detail);
	    	}
	    }
	});
}