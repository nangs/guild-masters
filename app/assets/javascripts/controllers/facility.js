GM.FacilityController = Ember.Controller.extend();

/**
 * show the facility page
 * @return {void}
 */
GM.FacilityController.showFacilityPage = function() {
	GM.FacilityModel.getFacilities(function (data) {
		if (GM.GuildmasterModel.guildmaster.state != "upgrading") {
			showView(facilitiesTemplate(data));
		} else {
			showView("The Guild is being upgraded, the facilities cannot be used at the moment");
		}
	});
}

/**
 * show the page for assinging adventurer to facility
 * @param  {integer} id
 *         the id of the facility
 * @return {void}
 */
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
		if (adventurers.length == 0) {
			showView('There are no adventurers available to be sent to the ' + facility.name);
		} else {
			GM.AdventurerController.showAdventurerWithGraph(adventurers, adventurerAssignTableTemplate, facilityView) 		
		}
	});
}

/**
 * assign the adventurers to the facility
 * @param  {integer} id
 *         the id of the facility
 * @param  {integer} capacity
 *         the capacity of the facility
 * @return {void}
 */
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

/**
 * [processErrorMessage description]
 * @param  {string} error_msg
 *         the error msg flag returned from the backend
 * @return {void}
 */
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

/**
 * render alert message
 * @param  {string} message
 * @return {void}
 */
GM.FacilityController.renderAlertMessage = function (message) {
	var alertMessage = alertMessageTemplate({'message' : message});
    $('#alert').html(alertMessage);
}