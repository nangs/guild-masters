$(function(){
	$('button').click(function(){
		var section = $(this).attr('id');
		showSection(section);
	});
})

function showSection(section){
	var view;
	switch(section){
		case 'home':
			view = '';
			break;
		case 'adventurers':
			view = adventurerNewButton + adventurersTableTemplate(GM.AdventurerController.adventurers_list);
			break;
		case 'quests':
			view = questNewButton + questsTableTemplate(GM.QuestController.quest_list);
			break;
	};
	showView(view);

}
function showView(view){
	$('#mainContainer').html(view);
}