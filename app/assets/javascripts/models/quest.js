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
	    	GM.QuestModel.quest_list.quests.push(data);
	    	showView(questNewTemplate(data));
	    }
	});
}

GM.QuestModel.getAllQuests = function (func) {
	$.ajax({
		type: 'POST',
	    url: 'quests.json',
	    data: {
	    	cmd: 'get'
	    },
	    success: function(data) {
	    	GM.QuestModel.quest_list = data;
	    	func(GM.QuestModel.quest_list);
	    }
	});
}

GM.QuestModel.assign = function(id, assigned) {
	$.ajax({
		type: 'POST',
	    url: 'events.json',
	    data: {
	    	cmd: 'create_quest_event',
	    	quest_id: id,
	    	adventurers_ids: assigned
	    },
	    success: function(data) {
	    	console.log(data);
	    	showView('Quest successfully assigned!');
	    	setupTimeBar();
	    }
	});
}