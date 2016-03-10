GM.FacilityModel = DS.Model.extend();

GM.FacilityModel.getFacilities = function (func) {
	$.ajax({
		type: 'GET',
	    url: 'facilities.json',
	    success: function(data) {
	    	GM.FacilityModel.facilities = data.facilities;
	    	func(data);
	    }
	});
}

GM.FacilityModel.assign = function(id, assigned) {
	$.ajax({
		type: 'POST',
	    url: 'facilityevents.json',
	    data: {
	    	facility_id: id,
	    	adventurers_ids: assigned
	    },
	    success: function(data) {
	    	console.log(data);
	    	if (data.msg == "error") {
	    		console.log(data.detail);
	    	} else {
	    		showView('Adventueres successfully assigned');
	    	}
	    	setupTimeBar();
	    }
	});
}