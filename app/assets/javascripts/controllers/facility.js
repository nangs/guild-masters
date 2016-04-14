GM.FacilityController = Ember.Controller.extend();

GM.FacilityController.showFacilityPage = function() {
	GM.FacilityModel.getFacilities(function (data) {
		if (GM.GuildmasterModel.guildmaster.state != "upgrading") {
			showView(facilitiesTemplate(data));
		} else {
			showView("The Guild is being upgraded, the facilities cannot be used at the moment");
		}
	});
}

GM.FacilityController.showAssign = function(id) {
	var facilities = GM.FacilityModel.facilities;
	var facility;
	for (var f in facilities) {
		if (facilities[f]['id'] == id) {
			facility = facilities[f];
		}
	}
	var facilityView = facilityAssignTemplate(facility);
	GM.AdventurerModel.getAllAdventurers(function () {
		var adventurers = GM.AdventurerModel.adventurers_list;
		switch (facility.name) {
			case 'clinic' :
				adventurers = GM.AdventurerController.filterForClinic(adventurers);
				break;
			case 'canteen' :
				adventurers = GM.AdventurerController.filterForCanteen(adventurers);
				break;
		}
		console.log(adventurers);
		if (adventurers.length == 0) {
			showView('There are no adventurers available to be sent to the ' + facility.name);
		} else {
			var adventurersView = adventurerAssignTemplate({"adventurers" : adventurers});
			showView(facilityView + adventurersView);			
		}
	});
}

GM.FacilityController.assign = function(id, capacity) {
	var assigned = [];
	$.each($("input:checked"), function (){
		assigned.push($(this).val());
	});
	if (assigned.length == 0) {
		GM.FacilityController.renderAlertMessage('Please select at least one adventurer.')
	} else if (assigned.length > capacity) {
		GM.FacilityController.renderAlertMessage('Please select at most ' + capacity + ' adventurer.')
	} else {
		GM.FacilityModel.assign(id, assigned);
	}	
}

GM.FacilityController.processErrorMessage = function (error_msg) {
	var message = '';
	switch (error_msg) {
		case "not_enough_gold":
			message = "Sorry you do not have enough gold to proceed.";
			break;
		default:
			message = "An unknown error occured. Please contact the admin to resolve the issue.";
	}
	GM.FacilityController.renderAlertMessage(message);
}

GM.FacilityController.renderAlertMessage = function (message) {
	var alertMessage = alertMessageTemplate({'message' : message});
    $('#alert').html(alertMessage);
}