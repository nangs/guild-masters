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

GM.AdventurerModel.getAllAdventurers = function () {
	$.ajax({
		type: 'GET',
	    url: 'adventurers.json',
	    success: function(data) {
	    	GM.AdventurerModel.adventurers_list = data;
	    }
	});
}

GM.AdventurerModel.getNewAdventurers = function () {
	$.ajax({
		type: 'POST',
	    url: 'adventurers.json',
	    success: function(data) {
	    	console.log(data);
	    	// GM.AdventurerModel.new_adventure = data;
	    	var new_adventure = adventurerNewTemplate(data);
	    	GM.AdventurerModel.adventurers_list.adventurers.push(data);
	    	showView(new_adventure);
	    }
	});
}

GM.AdventurerModel.getAllAdventurers();