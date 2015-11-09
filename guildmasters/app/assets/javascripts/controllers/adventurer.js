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
	    	// GM.AdventurerController.new_adventure = data;
	    	var new_adventure = adventurerNewTemplate(data);
	    	GM.AdventurerController.adventurers_list.adventurers.push(data);
	    	showView(new_adventure);
	    }
	});
}

GM.AdventurerController.getAllAdventurers();