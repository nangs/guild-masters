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
		var adventurersView = adventurerAssignTemplate({"adventurers" : adventurers});
		showView(facilityView + adventurersView);
	});
}

GM.FacilityController.assign = function(id) {
	var assigned = [];
	$.each($("input:checked"), function (){
		assigned.push($(this).val());
	});
	GM.FacilityModel.assign(id, assigned);
}