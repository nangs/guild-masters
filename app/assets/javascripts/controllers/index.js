GM.IndexController = Ember.Controller.extend();

function showHomePage(data) {
    showView(data);
}

function showSection(section){
	var view;
    GM.renderDetailBox = null;
	switch(section){
		case 'events':
            GM.EventModel.getAllEvents(function (events) {
                GM.EventController.showEvents(events);          
            });
            break;
		case 'adventurers':
            GM.AdventurerController.showAdventurerPage();
			break;
		case 'quests':
            GM.QuestController.showQuestPage();
			break;
		case 'home':
			GM.GuildmasterModel.getGuildmaster(showHomePage);
            break;
        case 'facilities':
            GM.FacilityController.showFacilityPage();
            break;
        case 'scout':
            GM.ScoutController.setupScout();
	};
}

function showView(view){
	$('#mainContainer').html(view);
}

$(function(){
    var isLoggedin = false;//localStorage.getItem('seesionID');
    var sessionID = sessionStorage.getItem('loggedIn');
    if (sessionID) {
        showGame();
    }
    else {
		setupLoginPage();
	}	
});

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
                    var msg = feedback.msg;
                    if (msg == 'success') {
                        var guild = feedback.guilds[0];
                        GM.GuildModel.postGuildID(guild.id);
                        sessionStorage.setItem('loggedIn', 1);
                        showGame();
                    } else {
                        switch(feedback.detail) {
                            case 'not_activated':
                                GM.IndexController.showEmailNotActivated(email);
                                break;
                            case 'wrong_password':
                                showWrongPasswordError();
                                break;
                            case 'invalid_account':
                                showEmailNotValid();
                                break;
                            case 'unknown':
                                showLoginError();
                                break;
                        }    
                    }
                }
            });
        }
    });
    $('#forgetPassword').mouseup(function() {
        var email = $('#email').val();
        var password = $('#password').val();
        setupForgetPasswordPage(email, password);
    });
    
    $('#signupPage').mouseup(function() {
        var email = $('#email').val();
        var password = $('#password').val();

    	$('#indexPage').html(signupTemplate);
    	setupSignupPage(email, password);
    });
    $(document).keypress(function(e) {
        if(e.which == 13) {
            $('#loginButton').mouseup();
        }
    });
}

function setupSignupPage(email, password) {
    var submitted = false;
    $('#email').val(email);
    $('#password').val(password);
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
                    var msg = feedback.msg;
                    if (msg == 'success') {
                        showSuccessSignupPage(email);
                    } else {
                        switch(feedback.detail) {
                            case 'account_taken':
                                showEmailTaken();
                                break;
                            case 'not_activated':
                                GM.IndexController.showEmailNotActivated(email);
                                break;
                            case 'unknown':
                                showSignupError();
                                break;
                        }                        
                    }
                }
            });
        }
    });
    $(document).keypress(function(e) {
        if(e.which == 13) {
            $('#signupButton').mouseup();
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
    setupTimeBar();
}

function setupTimeBar(){
    GM.GuildmasterModel.getGuildmaster(function() {
        GM.EventModel.getAllEvents(function(events) {
            console.log(events);
            renderTimeBar(events, GM.GuildmasterModel.guildmaster.game_time);
        });        
    })
}

function showDifferentPasswordError() {
	showAlertMessage('The two password you entered are different');
}


function setupForgetPasswordPage(email, password) {
    $('#indexPage').html(resetPasswordTemplate);
    $('#email').val(email);
    $('#password').val(password);
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
                    var msg = feedback.msg;
                    if (msg == 'success') {
                        showAlertMessage("The confirmation token has been sent to your email.");
                    } else {
                        switch(feedback.detail) {
                            case 'not_activated':
                                GM.IndexController.showEmailNotActivated(email);
                                break;
                            case 'invalid_account':
                                showEmailNotValid();
                                break;
                            case 'unknown':
                                showSignupError();
                                break;
                        }
                    }
                }
            });
        }
    });
    $('#resetPassword').mouseup(function() {
        var email = $('#email').val();
        var password = $('#password').val();
        var confirmPassword = $('#confirmPassword').val();
        var token = $('#token').val();

        if (password != confirmPassword) { // check whether the two passwords are the same
            showDifferentPasswordError();
        } else if (password.length < 6){
            passwordTooShortError();
        } else if (email == ''){
            showSignupNullError('email');
        } else if (password == '') {
            showSignupNullError('password');
        } else if (token == '') {
            showSignupNullError('Confirmation code');
        }
        
        else {
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
                    var msg = feedback.msg;
                    if (msg == 'success') {
                        showSuccessChangePasswordPage();
                    } else {
                        switch(feedback.detail) {
                            case 'wrong_token':
                                showWrongToken();
                                break;
                            case 'not_activated':
                                GM.IndexController.showEmailNotActivated(email);
                                break;
                            case 'invalid_account':
                                showEmailNotValid();
                                break;
                            case 'unknown':
                                showSignupError();
                                break;
                        }
                    }
                }
            });
        }
    });
}

function showSuccessChangePasswordPage() {
    $('#indexPage').html(resetPasswordSuccessTemplate);
    $('#goToLogin').mouseup(function() {
        setupLoginPage();
    });
}

function showSuccessSignupPage(email) {
	console.log('Signup is successful!');
	$('#indexPage').html(signupSuccessTemplate);
    setupActivateAccountButton(email);
    setupResendEmailButton(email);
}

function setupActivateAccountButton(email) {
    $('#activateAccount').mouseup(function() {
        var code = $('#activationCode').val();
        var email = $('#email').val();
        if (!code) {
            showAlertMessage("Please enter the activation code");
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
                    if (feedback.msg == 'success') {
                        showSuccessActivatePage();
                    }
                    else {
                        switch(feedback.detail) {
                            case 'wrong_token':
                                showWrongToken();
                                break;
                            case 'already_activated':
                                showEmailAlreadyActivated();
                                break;
                            case 'invalid_account':
                                showEmailNotValid();
                                break;
                        }
                    }
                }
            });
        }
    });
}

function setupResendEmailButton(email) {
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
                if (feedback.msg == 'success') {
                    showAlertMessage("Another email has been sent to you.");
                }
                else {
                    switch(feedback.detail) {
                        case 'not_activated':
                            GM.IndexController.showEmailNotActivated();
                            break;
                        case 'invalid_account':
                            showEmailNotValid();
                            break;
                        case 'unknown':
                            showUnknownError();
                            break;
                    }
                }
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

function logout() {
    $.ajax({
        type: 'DELETE',
        url: 'sessions.json',
        success: function(feedback) {
            console.log(feedback);
            sessionStorage.removeItem('loggedIn');
            location.reload();
        }
    });
}

function showWrongPasswordError() {
    showAlertMessage('The password you entered is wrong.');
}

function showWrongToken () {
    showAlertMessage('The code you entered is wrong.');
}

function showEmailTaken() {
	showAlertMessage('The email you used to register is already taken.');
}

function showEmailNotValid() {
    showAlertMessage('The email you entered is not valid.');
}
    
GM.IndexController.showEmailNotActivated = function(email) {
    $('#indexPage').html(emailNotActivatedTemplate);
    setupActivateAccountButton(email);
    setupResendEmailButton(email);
}

function showEmailAlreadyActivated() {
    showAlertMessage('The email you entered is already activated.');
}

function showSignupError() {
	showAlertMessage('Some error occured during the signup process, please be patient while we are fixing it.');
}

function showSignupNullError(field) {
	showAlertMessage('You must enter a valid ' + field);
}

function passwordTooShortError() {
	showAlertMessage('The password must be at least than 6 characters');
}

function showLoginError() {
    showAlertMessage('Some error occured during login...');
}

function showAlertMessage(message) {
    var alertMessage = alertMessageTemplate({'message' : message});
    $('#alert').html(alertMessage);
}

