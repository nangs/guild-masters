GM.EventController = Ember.Controller.extend();

GM.EventController.questFailed = function (questEvent) {
	var message = 'The quest is failed. Your popularity is decreased by ' + questEvent.popularity_lost + '.\n';
	var adventurers = questEvent.adventurers;
	for (var a in adventurers) {
		var adventurer = adventurers[a];
		if (adventurer.state == 'dead') {
			message += 'Adventurer ' + adventurer.name + ' is dead during the Quest.\n';
		}
	}
	showView(message);
}