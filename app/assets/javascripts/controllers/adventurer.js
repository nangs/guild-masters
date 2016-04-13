GM.AdventurerController = Ember.Controller.extend();

GM.AdventurerController.filterAlive = function (adventurers) {
	return adventurers.filter(function(adventurer) {
		var isAlive = (adventurer.state != 'dead');
		return isAlive;
	});	
}

GM.AdventurerController.filterForClinic = function (adventurers) {
	return adventurers.filter(function(adventurer) {
		var isHPLow = (adventurer.hp < adventurer.max_hp);
		var isAvailable = (adventurer.state == 'available');
		return isHPLow && isAvailable;
	});
};

GM.AdventurerController.filterForCanteen = function (adventurers) {
	return adventurers.filter(function(adventurer) {
		var isHPLow = (adventurer.energy < adventurer.max_energy);
		var isAvailable = (adventurer.state == 'available');
		return isHPLow && isAvailable;
	});
};

GM.AdventurerController.filterForQuest = function (adventurers) {
	return adventurers.filter(function(adventurer) {
		var isReady = (adventurer.energy > 0 && adventurer.hp > 0);
		var isAvailable = (adventurer.state == 'available');
		return isReady && isAvailable;
	});
};

GM.AdventurerController.searchById = function (id) {
	var adventurers = GM.AdventurerModel.adventurers_list;
	for (var ad in adventurers) {
		var adventurer = adventurers[ad];
		if (adventurer.id == id) {
			return adventurer;
		}
	}
	return null;
}

GM.AdventurerController.showAdventurerPage = function() {
	GM.AdventurerModel.getAllAdventurers(function (data) {
	    var adventurers = GM.AdventurerController.filterAlive(data);
	    if (adventurers.length == 0) {
	    	showView("There is no Adventurer in your Guild, please try scouting for some Adventurers and Quests");
	    }
	    else {
	    	var view = adventurersTableTemplate({'adventurers' : adventurers});
	    	showView(view);	
	    }
	});
};