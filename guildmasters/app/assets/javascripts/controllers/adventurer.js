Handlebars.registerPartial('adventurer',  HandlebarsTemplates['adventurer/adventurer']);
var adventurersListTemplate =  HandlebarsTemplates['adventurer/adventurer_list'];
GM.AdventurerController = Ember.Controller.extend();

GM.AdventurerController.getAllAdventurers = function () {
	$.ajax({
		type: 'GET',
	    url: 'adventurers.json',
	    success: function(data) {
	    	console.log(data);
	    	GM.AdventurerController.adventurers_list = data;
	    }
	});
}


GM.AdventurerController.getAllAdventurers();