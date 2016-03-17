GM.EventController = Ember.Controller.extend();

GM.EventController.showEventResults = function (events) {
	var message = '';
	for (var e = 0; e < events.length; e++) {
		var eventReuslt = events[e];
		switch (eventReuslt.type) {
			case 'QuestEvent':
				if (eventReuslt.msg == "success") {
					message += questSuccessTemplate(eventReuslt);
				} else {
					message += questFailTemplate(eventReuslt);
				}
				break;
			case 'FacilityEvent':
				message += facilityResultTemplate(eventReuslt);
				break;
		}
	}
	showView(message);
}