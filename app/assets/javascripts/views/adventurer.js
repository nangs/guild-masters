Handlebars.registerPartial('adventurer',  HandlebarsTemplates['adventurer/adventurer']);
Handlebars.registerHelper('isAssigned', function(state, options){
	if(state == 'assigned' || state == 'resting') {
		return options.fn(this);
	}
	return options.inverse(this);
});
Handlebars.registerHelper('isDead', function(state, options){
	if(state == 'dead') {
		return options.fn(this);
	}
	return options.inverse(this);
});
var adventurerTemplate = HandlebarsTemplates['adventurer/adventurer'];
var adventurersListTemplate = HandlebarsTemplates['adventurer/adventurer_list'];
var adventurerNewTemplate = HandlebarsTemplates['adventurer/adventurer_new'];
var adventurersTableTemplate = HandlebarsTemplates['adventurer/adventurer_table'];
var adventurerSummaryTableTemplate = HandlebarsTemplates['adventurer/adventurer_summary_table'];
var adventurerNewButton = HandlebarsTemplates['adventurer/adventurer_get']();
var adventurerAssignTemplate = HandlebarsTemplates['adventurer/adventurer_assign'];
var adventurerDisplayTemplate = HandlebarsTemplates['adventurer/adventurer_display'];

function renderAdventureDetails(adventurer) {
	var canvas;
	if (GM.AdventurerView.renderDetailBox) {
		canvas = GM.AdventurerView.renderDetailBox;
	} else {
		canvas = new fabric.Canvas('adventurer_detail');
	}
	canvas.clear();
	



	GM.AdventurerView.renderDetailBox = canvas;
	return canvas;
}