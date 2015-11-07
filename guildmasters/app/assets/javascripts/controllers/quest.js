GM.QuestController = Ember.Controller.extend();

GM.QuestController.getNewQuests = function(){
	$.ajax({
		type: 'POST',
	    url: 'quests.json',
	    success: function(data) {
	    	GM.QuestController.new_quests = data;
	    	showView(newQuestsTemplate(data));
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
		    			data['quests'][q].description = 'A dangerous moster has to be killed';
		    		}
		    		else {
		    			data['quests'][q].description = 'We are looking for a hidden treasurer';
		    		}
		    	}
	    	}
	    	GM.QuestController.quest_list = data;
	    }
	});
}

GM.QuestController.getAllQuests();