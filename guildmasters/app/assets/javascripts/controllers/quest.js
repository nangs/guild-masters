GM.QuestController = Ember.Controller.extend();

GM.QuestController.getNewQuests = function(){
	$.ajax({
		type: 'POST',
	    url: 'quests.json',
	   	data: {
	    	status: 'generate'
	    },
	    success: function(data) {
	    	GM.QuestController.new_quests = data;
    		if (!('description' in data)) {
	    		if (Math.random() > 0.2) {
	    			data.description = 'A dangerous monster has to be killed';
	    		}
	    		else {
	    			data.description = 'We are looking for a hidden treasure';
	    		}
	    	}
	    	GM.QuestController.quest_list.quests.push(data);
	    	showView(questNewTemplate(data));
	    }
	});
}

GM.QuestController.getAllQuests = function () {
	$.ajax({
		type: 'GET',
	    url: 'quests.json',
	    success: function(data) {
	    	// Stub descriptions
	    	for (q in data['quests']) {
	    		if (!('description' in data['quests'][q])) {
		    		if (Math.random() > 0.2) {
		    			data['quests'][q].description = 'A dangerous monster has to be killed';
		    		}
		    		else {
		    			data['quests'][q].description = 'We are looking for a hidden treasure';
		    		}
		    	}
	    	}
	    	GM.QuestController.quest_list = data;
	    }
	});
}

GM.QuestController.showAssign = function(id) {
	// Temporary way of getting the quest. 
	// The API should be designed in a way that a particular Quest can be directly retrieved by id.
	quest = GM.QuestController.quest_list['quests'][id-1];
	var questView = questAssignTemplate(quest);
	var adventurersView = adventurerAssignTemplate(GM.AdventurerController.adventurers_list);
	showView(questView + adventurersView);
}

GM.QuestController.assign = function(id) {
	var assigned = [];
	$.each($("input:checked"), function (){
		assigned.push($(this).val());
	});
	$.ajax({
		type: 'POST',
	    url: 'quests.json',
	    data: {
	    	status: 'assign',
	    	questId: id,
	    	adventurersIds: assigned
	    },
	    success: function(data) {
	    	showView('Quest successfully assigned!');
	    }
	});
}


GM.QuestController.getAllQuests();