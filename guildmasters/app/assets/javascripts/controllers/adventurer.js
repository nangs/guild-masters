GM.AdventurerController = Ember.Controller.extend();

GM.AdventurerController.getAllAdventurers = function () {
	$.ajax({
		type: 'GET',
	    url: 'adventurers.json',
	    success: function(data) {
	    	GM.AdventurerController.adventurers_list = data;
	    }
	});
}

GM.AdventurerController.getNewAdventurers = function () {
	$.ajax({
		type: 'POST',
	    url: 'adventurers.json',
	    success: function(data) {
	    	console.log(data);
	    	GM.AdventurerController.new_adventure = data;
	    }
	});
}

GM.AdventurerController.getAllAdventurers();