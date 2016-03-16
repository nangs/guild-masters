Handlebars.registerHelper('isCompleted', function(state, options){
	if(state == 'successful') {
		return options.fn(this);
	}
	return options.inverse(this);
});	
Handlebars.registerPartial('quest',  HandlebarsTemplates['quest/quest']);
var questTemplate = HandlebarsTemplates['quest/quest'];
var questsListTemplate = HandlebarsTemplates['quest/quest_list'];
var questNewTemplate = HandlebarsTemplates['quest/quest_new'];
var questsTableTemplate = HandlebarsTemplates['quest/quest_table'];
var questNewButton = HandlebarsTemplates['quest/quest_get']();
var questAssignTemplate = HandlebarsTemplates['quest/quest_assign'];var questFailTemplate = HandlebarsTemplates['quest/quest_result_fail'];