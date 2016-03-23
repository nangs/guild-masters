GM.QuestController = Ember.Controller.extend();

GM.QuestController.showAssign = function(id) {
	// Temporary way of getting the quest. 
	// The API should be designed in a way that a particular Quest can be directly retrieved by id.
	var quests = GM.QuestModel.quest_list['quests'];
	var quest;
	for (var q in quests) {
		if (quests[q]['id'] == id) {
			quest = quests[q];
		}
	}
	var questView = questAssignTemplate(quest);
	GM.AdventurerModel.getAllAdventurers(function () {
		var adventurers = GM.AdventurerController.filterForQuest(GM.AdventurerModel.adventurers_list.adventurers);
		if (adventurers.length == 0) {
			showView(questView + "<p>You do not have any adventurers to be assigned to the quest.</p>");
		} else {
			var adventurersView = adventurerAssignTemplate({'adventurers' : adventurers});
			showView(questView + adventurersView);
		}
	});
}

GM.QuestController.assign = function(id) {
	var assigned = [];
	$.each($("input:checked"), function (){
		assigned.push($(this).val());
	});
	if (assigned.length == 0) {
		GM.QuestController.showMessage("Please select at least one adventurer.");
	} else {
		GM.QuestModel.assign(id, assigned);
	}
}

GM.QuestController.showMessage = function (message) {
	var alertMessage = alertMessageTemplate({'message' : message});
    $('#alert').html(alertMessage);
}