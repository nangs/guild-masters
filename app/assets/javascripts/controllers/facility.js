GM.FacilityController = Ember.Controller.extend();

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
		var adventurers = GM.AdventurerModel.adventurers_list.adventurers;
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

GM.FacilityController.assign = function(id) {
	var assigned = [];
	$.each($("input:checked"), function (){
		assigned.push($(this).val());
	});
	if (assigned.length == 0) {
		GM.FacilityController.showMessage('Please select at least one adventure.')
	} else {
		GM.FacilityModel.assign(id, assigned);
	}	
}

GM.FacilityController.showMessage = function (message) {
	var alertMessage = alertMessageTemplate({'message' : message});
    $('#alert').html(alertMessage);
}