function showSection(section){
	var view;
	switch(section){
		case 'events':
			GM.EventModel.getAllEvents();
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
		showGame();
	} else {
		$('#indexPage').html(loginTemplate);
		setupLoginPage();
	}	
})

function setupLoginPage() {
    $('#signupPage').mouseup(function() {
    	$('#indexPage').html(signupTemplate);
    	setupSignupPage();
    });
}

function setupSignupPage() {
    var submitted = false;
    $('#signupButton').mouseup(function() {

        var email = $('#email').val();
        var password = $('#password').val();
        var confirmPassword = $('#confirmPassword').val();

        if (password != confirmPassword) { // check whether the two passwords are the same
        	showDifferentPasswordError();
        } else {
        	submitted = true;
            $.ajax({
                type: 'POST',
                url: 'accounts.json',
                data: {
                    email: email,
                    password: password
                },
                success: function(feedback) {
                	console.log(feedback);
                	showSuccessSignupPage();
                }
            });
        }
    });
}

function showGame() {
	$('#indexPage').html(gameTemplate);
	$('button').click(function(){
		var section = $(this).attr('id');
		showSection(section);
	});
	showSection('home');
	$('button').click(function(){
		var section = $(this).attr('id');
		showSection(section);
	});
}

function showDifferentPasswordError() {
	console.log('Password are different');
}

function showSuccessSignupPage() {

}
