GM.FacilityModel = DS.Model.extend();

GM.FacilityModel.getFacilities = function (func) {
	$.ajax({
		type: 'GET',
	    url: 'facilities.json',
	    success: function(data) {
	    	func(data);
	    }
	});
}