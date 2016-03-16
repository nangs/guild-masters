GM.EventController = Ember.Controller.extend();

GM.EventController.showQuestResults = function (questEvents) {
	var message = '';
	for (var qe = 0; qe < questEvents.length; qe++) {
		var questEvent = questEvents[qe];
		if (questEvent.msg == "success") {
			message += questSuccessTemplate(questEvent);
		} else {
			message += questFailTemplate(questEvent);
		}
	}
	showView(message);
}