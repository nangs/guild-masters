function showSection(section){
	var view;
	switch(section){
		case 'home':
			GM.GuildmasterController.guildmaster.guild = GM.GuildController.guild;
			GM.GuildmasterView = guildmasterTemplate(GM.GuildmasterController.guildmaster);
			view = GM.GuildmasterView;
			break;
		case 'events':
			view = nextEventTemplate(GM.nextEvent);
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

$(function(){
	$('button').click(function(){
		var section = $(this).attr('id');
		showSection(section);
	});
	showSection('home');
})