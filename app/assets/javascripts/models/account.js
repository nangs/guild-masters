GM.AccountModel = DS.Model.extend();

GM.AccountModel.login = function (email, password) {
	$.ajax({
	    type: 'POST',
	    url: 'sessions.json',
	    data: {
	        email: email,
	        password: password
	    },
	    success: function(feedback) {
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

GM.AccountModel.signup = function (email, username, password) {
	$.ajax({
	    type: 'POST',
	    url: 'accounts.json',
	    data: {
	    	cmd: 'signup',
	        email: email,
	        username: username,
	        password: password
	    },
	    success: function(feedback) {
	        var msg = feedback.msg;
	        if (msg == 'success') {
	            showSuccessSignupPage(email);
	        } else {
	            switch(feedback.detail) {
	                case 'account_taken':
	                    showEmailTaken();
	                    break;
	                case 'username_taken':
	                    showUsernameTaken();
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

GM.AccountModel.sendPasswordToken = function (email) {
    $.ajax({
        type: 'POST',
        url: 'accounts.json',
        data: {
            cmd: 'send_password_token',
            email: email
        },
        success: function(feedback) {
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

GM.AccountModel.updateAccount = function (email, password, token) {
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

GM.AccountModel.activateAccount = function (code, email) {
    $.ajax({
        type: 'POST',
        url: 'accounts.json',
        data: {
            cmd: 'activate_account',
            confirm_token: code,
            email: email
        },
        success: function(feedback) {
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

GM.AccountModel.resendEmail = function (email) {
    $.ajax({
        type: 'POST',
        url: 'accounts.json',
        data: {
            cmd: 'resend_email',
            email: email
        },
        success: function(feedback) {
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
}

GM.AccountModel.logout = function () {
	$.ajax({
        type: 'DELETE',
        url: 'sessions.json',
        success: function(feedback) {
            sessionStorage.removeItem('loggedIn');
            location.reload();
        }
    });
}