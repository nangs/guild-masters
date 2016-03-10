GM.AdventurerController = Ember.Controller.extend();

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