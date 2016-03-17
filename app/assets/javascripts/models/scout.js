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
	    	console.log(data)
	    }
	});
}