GM.Adventurer = DS.Model.extend({
	name: DS.attr('string'),
	hp: DS.attr('number'),
	max_hp: DS.attr('number'),
	energy: DS.attr('number'),
	max_energy: DS.attr('number'),
	attack: DS.attr('number'),
	defense: DS.attr('number'),
	vision: DS.attr('number'),
	state: DS.attr('string'),

	guild: DS.belongsTo('guild'),
	quest: DS.belongsTo('quest'),
	facility: DS.belongsTo('facility')
});

GM.AdventurerModel = DS.Model.extend();

/**
 * get all the adventurers from the database
 * @param  {function} func apply this input function to the adventurers
 * @return {void}     
 */
GM.AdventurerModel.getAllAdventurers = function (func) {
	$.ajax({
		type: 'POST',
	    url: 'adventurers.json',
	    data:{
	    	cmd : 'get'
	    },
		statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(data) {
	    	GM.AdventurerModel.adventurers_list = data.adventurers;
	    	func(GM.AdventurerModel.adventurers_list);
	    }
	});
}

/**
 * get one new adventurers from the database
 * @param  {function} func apply this input function to the adventurer
 * @return {void}     
 */
GM.AdventurerModel.getNewAdventurers = function (func) {
	$.ajax({
		type: 'POST',
	    url: 'adventurers.json',
	    statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(data) {
	    	var new_adventure = adventurerNewTemplate(data);
	    	GM.AdventurerModel.adventurers_list.adventurers.push(data);
	    	func(new_adventure);
	    }
	});
}