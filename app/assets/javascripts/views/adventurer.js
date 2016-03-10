Handlebars.registerPartial('adventurer',  HandlebarsTemplates['adventurer/adventurer']);
Handlebars.registerHelper('isAssigned', function(state, options){
	if(state == 'assigned' || state == 'resting') {
		return options.fn(this);
	}
	return options.inverse(this);
});
var adventurerTemplate = HandlebarsTemplates['adventurer/adventurer'];
var adventurersListTemplate = HandlebarsTemplates['adventurer/adventurer_list'];
var adventurerNewTemplate = HandlebarsTemplates['adventurer/adventurer_new'];
var adventurersTableTemplate = HandlebarsTemplates['adventurer/adventurer_table'];
var adventurerNewButton = HandlebarsTemplates['adventurer/adventurer_get']();
var adventurerAssignTemplate = HandlebarsTemplates['adventurer/adventurer_assign'];