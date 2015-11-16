function showSection(section){
	var view;
	switch(section){
		case 'events':
			if (GM.nextEvent) {
				view = nextEventTemplate(GM.nextEvent);
			} else {
				view = "There is no event that is in progress";
			}
			break;
		case 'adventurers':
			view = adventurerNewButton + adventurersTableTemplate(GM.AdventurerController.adventurers_list);
			break;
		case 'quests':
			view = questNewButton + questsTableTemplate(GM.QuestController.quest_list);
			break;
		case 'home':
			GM.GuildmasterController.getGuildmaster();
			GM.GuildmasterController.guildmaster.guild = GM.GuildController.guild;
			GM.GuildmasterView = guildmasterTemplate(GM.GuildmasterController.guildmaster);
			view = GM.GuildmasterView;
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
	GM.GuildmasterController.getGuildmaster();
	showSection('home');
})