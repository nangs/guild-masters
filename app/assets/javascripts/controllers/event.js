GM.EventController = Ember.Controller.extend();

GM.EventController.showEventResults = function (eventResults) {
	var message = '';
	var events = eventResults.events;
	var refresh = eventResults.refresh;
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
			case "ScoutEvent":
				message += scoutResultTemplate(eventReuslt);
		}
		message += "<hr>";
	}
	if (refresh.length == 1) {
		var refreshes = refresh[0];
		for (var r=0; r<refreshes.length; r++) {
			var new_gain = refreshes[r];
			new_gain.num_adv = new_gain.new_adventurers.length;
			new_gain.num_quest = new_gain.new_quests.length;
			message += refreshTemplate(new_gain);
		}
	}
	showView(message);
}

GM.EventController.showEvents = function (events) {
	if (events.length == 0) {
		return showView("There is no event that is in progress");
	} else {
		for (var e = 0; e < events.length; e++) {
			var eve = events[e];
			switch (eve.type) {
				case 'QuestEvent':
					eve.description = eve.quest.description;
					eve.adventurer_names = "";
					for (var ad=0; ad < eve.adventurers.length; ad++) {
						eve.adventurer_names += eve.adventurers[ad].name;
						if (ad < eve.adventurers.length - 1){
							eve.adventurer_names += ", ";
						}
					}
					break;
				case 'FacilityEvent':
					eve.description = "Your adventurer is in the " + eve.facility.name;
					eve.adventurer_names = eve.adventurer.name;
					break;
				case "ScoutEvent":
					eve.description = "The GuildMaster is scouting for Adventurers and Quests";
					eve.adventurer_names = "The GuildMaster";
			}
		}
		showView(eventListTemplate({'events': events}));
	}
}