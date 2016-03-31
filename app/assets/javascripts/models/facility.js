GM.FacilityModel = DS.Model.extend();

GM.FacilityModel.getFacilities = function (func) {
	$.ajax({
		type: 'POST',
	    url: 'facilities.json',
	    data: {
	    	cmd: 'get'
	    },
	    success: function(data) {
	    	GM.FacilityModel.facilities = data.facilities;
	    	func(data);
	    }
	});
}

GM.FacilityModel.assign = function(id, assigned) {
	$.ajax({
		type: 'POST',
	    url: 'facility_events.json',
	    data: {
	    	cmd: 'create',
	    	facility_id: id,
	    	adventurers_ids: assigned
	    },
	    success: function(data) {
	    	console.log(data);
	    	if (data.msg == "error") {
	    		GM.FacilityController.showMessage(data.detail);
	    	} else {
	    		showView('Adventueres successfully assigned');
	    	}
	    	setupTimeBar();
	    }
	});
}