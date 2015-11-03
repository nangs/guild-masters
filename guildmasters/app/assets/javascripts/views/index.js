$(function(){
	$('button').click(function(){
		var show = $(this).attr('id');
		var view;
		switch(show){
			case 'home':
				view = '';
				break;
			case 'adventurers':
				view = adventurersListTemplate(GM.AdventurerController.adventurers_list);
				break;
			case 'quests':
				view = questsListTemplate(GM.QuestController.quest_list);
				break;
		};
		showView(view);
	});
})

function showView(view){
	$('#mainContainer').html(view);
}