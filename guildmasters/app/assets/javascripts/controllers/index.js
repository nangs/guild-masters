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
            sleep(100);
			GM.GuildModel.getAllGuilds();
            sleep(100);
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
	var isLoggedin = false;//localStorage.getItem('seesionID');
	if (isLoggedin) {
		showGame();
	$('button').click(function(){
		var section = $(this).attr('id');
		showSection(section);
	});
	} else {
		setupLoginPage();
	}	
})

function setupLoginPage() {
	$('#indexPage').html(loginTemplate);
	var submitted = false;
    $('#loginButton').mouseup(function() {
    	var email = $('#email').val();
        var password = $('#password').val();

		if (email == ''){
        	showSignupNullError('email');
        } else if (password == '') {
        	showSignupNullError('password');
        } 
        else {
        	submitted = true;
            $.ajax({
                type: 'POST',
                url: 'sessions.json',
                data: {
                    email: email,
                    password: password
                },
                success: function(feedback) {
                	console.log(feedback);
                    if (feedback == 'error') {
                        showLoginError();
                    } else {
                        localStorage.setItem('seesionID', feedback);
                        showGame();
                    }
                }
            });
        }
    });
    $('#forgetPassword').mouseup(function() {
        setupForgetPasswordPage();
    });
    
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
        } else if (password.length < 6){
            passwordTooShortError();
        } else if (email == ''){
            showSignupNullError('email');
        } else if (password == '') {
            showSignupNullError('password');
        } 
        else {
            submitted = true;
            $.ajax({
                type: 'POST',
                url: 'accounts.json',
                data: {
                	cmd: 'signup',
                    email: email,
                    password: password
                },
                success: function(feedback) {
                	console.log(feedback);
                	switch(feedback) {
                		case 'success':
                			showSuccessSignupPage(email);
                			break;
                		case 'taken':
                			showEmailTaken();
                			break;
                        case 'not_activated':
                            showEmailNotActivated();
                            break;
                		case 'error':
                			showSignupError();
                			break;
                	}
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
	alert('The two password you entered are different');
}

function changePassword() {
    $.ajax({
        type: 'POST',
        url: 'accounts.json',
        data: {
            cmd: 'update_account',
            email: email,
            password: password,
            confirm_token: token
        },
        success: function(feedback) {
            console.log(feedback);
            if (feedback == 'success') {
                showSuccessChangePasswordPage();
            }
        }
    });
}

function setupForgetPasswordPage() {
    $('#indexPage').html(resetPasswordTemplate);
    $('#getTokenForReset').mouseup(function() {
        var email = $('#email').val();
        if (email == ''){
            showSignupNullError('email');
        }
        else {
            $.ajax({
                type: 'POST',
                url: 'accounts.json',
                data: {
                    cmd: 'send_password_token',
                    email: email
                },
                success: function(feedback) {
                    console.log(feedback);
                    alert("The confirmation token has been sent to your email.");
                }
            });
        }
    });
}

function showSuccessChangePasswordPage() {

}

function showSuccessSignupPage(email) {
	console.log('Signup is successful!');
	$('#indexPage').html(signupSuccessTemplate);
    $('#activateAccount').mouseup(function() {
        var code = $('#activationCode').val();
        var email = $('#email').val();
        if (!code) {
            alert("Please enter the activation code");
        }
        else {
            $.ajax({
                type: 'POST',
                url: 'accounts.json',
                data: {
                    cmd: 'activate_account',
                    confirm_token: code,
                    email: email
                },
                success: function(feedback) {
                    console.log(feedback);
                    switch(feedback) {
                        case 'success':
                            showSuccessActivatePage();
                            break;
                        case 'fail':
                            alert('The activation entered code is wrong');
                            break;
                    }
                }
            });
        }
    });
    $('#resendEmail').mouseup(function() {
        $.ajax({
            type: 'POST',
            url: 'accounts.json',
            data: {
                cmd: 'resend_email',
                email: email
            },
            success: function(feedback) {
                console.log(feedback);
                alert("Another email has been sent to you.");
            }
        });
    });
}

function showSuccessActivatePage() {
    $('#indexPage').html(activateSuccessTemplate);
    $('#goToLogin').mouseup(function() {
        setupLoginPage();
    });
}

function showEmailTaken() {
	alert('The email you used to register is already taken.');
}

function showSignupError() {
	alert('Some error occured during the signup process, please be patient while we are fixing it.');
}

function showSignupNullError(field) {
	alert('You must enter a valid ' + field);
}

function passwordTooShortError() {
	alert('The password must be at least than 6 characters');
}

function showLoginError() {
    alert('Some error occured during login...');
}

function sleep(milliseconds) {
    var start = new Date().getTime();
        for (var i = 0; i < 1e7; i++) {
        if ((new Date().getTime() - start) > milliseconds){
            break;
        }
    }
}