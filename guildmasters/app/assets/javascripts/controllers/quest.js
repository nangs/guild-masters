GM.QuestController = Ember.Controller.extend();

GM.QuestController.showAssign = function(id) {
	// Temporary way of getting the quest. 
	// The API should be designed in a way that a particular Quest can be directly retrieved by id.
	quest = GM.QuestModel.quest_list['quests'][id-1];
	var questView = questAssignTemplate(quest);
	var adventurersView = adventurerAssignTemplate(GM.AdventurerModel.adventurers_list);
	showView(questView + adventurersView);
}

GM.QuestController.assign = function(id) {
	var assigned = [];
	$.each($("input:checked"), function (){
		assigned.push($(this).val());
	});

}