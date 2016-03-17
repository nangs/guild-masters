GM.EventController = Ember.Controller.extend();

GM.EventController.showEventResults = function (events) {
	var message = '';
	for (var e = 0; e < events.length; e++) {
		var eventReuslt = events[e];
		switch (eventReuslt.type) {
			case 'QuestEvent':
				if (questEvent.msg == "success") {
					message += questSuccessTemplate(questEvent);
				} else {
					message += questFailTemplate(questEvent);
				}
				break;
			case 'FacilityEvent':
				message += facilityResultTemplate(questEvent);
				break;
		}
	}
	showView(message);
}