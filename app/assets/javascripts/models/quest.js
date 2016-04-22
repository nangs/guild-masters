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
	    statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(data) {
	    	GM.QuestModel.new_quests = data;
	    	GM.QuestModel.quest_list.quests.push(data);
	    	showView(questNewTemplate(data));
	    }
	});
}

/**
 * get all the quests belong to the current guild
 * @param  {function} func
 *         apply the function to the quests obtained
 * @return {void}
 */
GM.QuestModel.getAllQuests = function (func) {
	$.ajax({
		type: 'POST',
	    url: 'quests.json',
	    data: {
	    	cmd: 'get'
	    },
	    statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(data) {
	    	GM.QuestModel.quest_list = data.quests;
	    	func(GM.QuestModel.quest_list);
	    }
	});
}

/**
 * assign adventurers to a quest
 * @param  {integer} id
 *         the id of the quest
 * @param  {integer[]} assigned
 *         a array containing the ids of the adventurers
 * @return {void} 
 */
GM.QuestModel.assign = function(id, assigned) {
	$.ajax({
		type: 'POST',
	    url: 'events.json',
	    data: {
	    	cmd: 'create_quest_event',
	    	quest_id: id,
	    	adventurers_ids: assigned
	    },
	    statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(data) {
	    	showView('Quest successfully assigned!');
	    	setupTimeBar();
	    }
	});
}