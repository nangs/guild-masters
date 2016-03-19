GM.ScoutModel = DS.Model.extend();

GM.ScoutModel.scout = function (time, gold) {
	$.ajax({
		type: 'POST',
	    url: 'scout_events.json',
	    data : {
	    	time_spent: time,
	    	gold_spent: gold
	    },
	    success: function(data) {
	    	if (data.msg == 'success') {
	    		showView('You will spend ' + gold + ' gold for this scouting.');
	    		setupTimeBar();
	    	} else {
	    		console.log(data);
	    	}
	    }
	});
}