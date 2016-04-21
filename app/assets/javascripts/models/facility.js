GM.FacilityModel = DS.Model.extend();

/**
 * get all the facilities from the database
 * @param  {function} func
 *         apply this input function to the facilities
 * @return {void}     
 */
GM.FacilityModel.getFacilities = function (func) {
	$.ajax({
		type: 'POST',
	    url: 'facilities.json',
	    data: {
	    	cmd: 'get'
	    },
	    statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(data) {
	    	GM.FacilityModel.facilities = data.facilities;
	    	func(data);
	    }
	});
}

/**
 * assign some adventurers to the facility
 * @param  {integar} id
 *         the id of the facility
 * @param  {array} assigned
 *                   The array containing the ids for the adventurers
 *                   which are assigned to the facility
 * @return {void}
 */
GM.FacilityModel.assign = function(id, assigned) {
	$.ajax({
		type: 'POST',
	    url: 'events.json',
	    data: {
	    	cmd: 'create_facility_event',
	    	facility_id: id,
	    	adventurers_ids: assigned
	    },
	    statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(data) {
	    	console.log(data);
	    	if (data.msg == "error") {
	    		GM.FacilityController.processErrorMessage(data.detail);
	    	} else {
	    		showView('Adventueres successfully assigned');
	    	}
	    	setupTimeBar();
	    }
	});
}