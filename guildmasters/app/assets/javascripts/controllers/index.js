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
			view = adventurerNewButton + adventurersTableTemplate(GM.AdventurerModel.adventurers_list);
			break;
		case 'quests':
			view = questNewButton + questsTableTemplate(GM.QuestModel.quest_list);
			break;
		case 'home':
			GM.GuildmasterModel.getGuildmaster();
			GM.GuildModel.getAllGuilds();
			GM.GuildmasterModel.guildmaster.guild = GM.GuildModel.guild;
			GM.GuildmasterView = guildmasterTemplate(GM.GuildmasterModel.guildmaster);
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
	GM.GuildmasterModel.getGuildmaster();
	var isLoggedin = false;
	if (isLoggedin) {
		$('#indexPage').html(loginTemplate);
	} else {
		$('#indexPage').html(gameTemplate);
		$('button').click(function(){
			var section = $(this).attr('id');
			showSection(section);
		});
		showSection('home');
		console.log('here');
		$('button').click(function(){
			var section = $(this).attr('id');
			showSection(section);
		});
	}
	
})