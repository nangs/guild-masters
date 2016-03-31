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
	    success: function(data) {
	    	if (data.msg == 'success') {
	    		showView('You will spend ' + gold + ' gold for this scouting.');
	    		GM.GuildmasterModel.getGuildmaster();
	    		setupTimeBar();
	    	} else {
	    		console.log(data);
	    	}
	    }
	});
}