GM.QuestController = Ember.Controller.extend();

GM.QuestController.getNewQuests = function(){
	$.ajax({
		type: 'POST',
	    url: 'quests.json',
	    success: function(data) {
	    	GM.QuestController.new_quests = data;
    		if (!('description' in data)) {
	    		if (Math.random() > 0.2) {
	    			data.description = 'A dangerous moster has to be killed';
	    		}
	    		else {
	    			data.description = 'We are looking for a hidden treasurer';
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

GM.QuestController.getAllQuests();