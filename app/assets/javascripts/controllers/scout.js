GM.ScoutController = Ember.Controller.extend();

GM.ScoutController.setupScout = function() {
	if (GM.GuildmasterModel.guildmaster.state == "scouting") {
		showView("The GuildMaster is currently scouting for Adventurers and Quests.");
	}
	if (GM.GuildmasterModel.guildmaster.state == "upgrading") {
		showView("The GuildMaster is currently upgrading the Guild.");
	}
	else {
		showView(scoutSetTemplate);

		var goldSlider = $("#goldSelected");
		var gold = GM.GuildmasterModel.guildmaster.gold;
		goldSlider.attr("data-slider-max", gold);
		goldSlider.slider();	
		goldSlider.on("slide", function(slideEvt) {
			$("#goldSelectedValue").html(slideEvt.value);
		});

		var timeSlider = $("#timeSelected");
		timeSlider.slider();	
		timeSlider.on("slide", function(slideEvt) {
			$("#timeSelectedValue").html(slideEvt.value);
		});

		$("#scoutAssign").mouseup(function() {
			GM.ScoutModel.scout(timeSlider.val(), goldSlider.val());
		});	
	}
}

GM.ScoutController.showMessage = function (error_msg) {
	var message = '';
	switch (error_msg) {
		case "guildmaster_busy":
			message = "The GuildMaster is currently unavailable for scouting.";
			break;
		case "guild_full":
			message = "The maximum capacity of the Guild is reached. \
					Level up the Guild in order to receive more Adventurers and Quests.";
			break;
		case "not_enough_gold":
			message = "There is not enough gold for scouting."
			break;
	}
	GM.ScoutController.renderAlertMessage(message);
}

GM.ScoutController.renderAlertMessage = function (message) {
	var alertMessage = alertMessageTemplate({'message' : message});
    $('#alert').html(alertMessage);
}