GM.Quest = DS.Model.extend({
	difficulty: DS.attr('number'),
	state: DS.attr('string'),
	reward: DS.attr('number'),
	description: DS.attr('string'),

	adventurers: DS.hasMany('adventurer')
});


GM.QuestModel = DS.Model.extend();

GM.QuestModel.getNewQuests = function(){
	$.ajax({
		type: 'POST',
	    url: 'quests.json',
	   	data: {
	    	cmd: 'generate'
	    },
	    success: function(data) {
	    	GM.QuestModel.new_quests = data;
    		if (!('description' in data)) {
	    		if (data.id % 3 != 1) {
	    			data.description = 'A dangerous monster has to be killed';
	    		}
	    		else {
	    			data.description = 'We are looking for a hidden treasure';
	    		}
	    	}
	    	GM.QuestModel.quest_list.quests.push(data);
	    	showView(questNewTemplate(data));
	    }
	});
}

GM.QuestModel.getAllQuests = function () {
	$.ajax({
		type: 'GET',
	    url: 'quests.json',
	    success: function(data) {
	    	// Stub descriptions
	    	for (q in data['quests']) {
	    		if (!('description' in data['quests'][q])) {
		    		if (data['quests'][q].id % 3 != 1) {
		    			data['quests'][q].description = 'A dangerous monster has to be killed';
		    		}
		    		else {
		    			data['quests'][q].description = 'We are looking for a hidden treasure';
		    		}
		    	}
	    	}
	    	GM.QuestModel.quest_list = data;
	    }
	});
}

GM.QuestModel.assign = function(id) {
	$.ajax({
		type: 'POST',
	    url: 'quests.json',
	    data: {
	    	cmd: 'assign',
	    	questId: id,
	    	adventurersIds: assigned
	    },
	    success: function(data) {
	    	console.log(data);
	    	showView('Quest successfully assigned!');
	    	GM.QuestModel.getAllQuests();
	    	GM.AdventurerModel.getAllAdventurers();
	    	GM.EventModel.getAllEvents();
	    }
	});
}

GM.QuestModel.getAllQuests();