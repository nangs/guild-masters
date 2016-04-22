GM.IndexController = Ember.Controller.extend();

/**
 * show a particular section
 * @param  {string} section
 *         the name of the section
 * @return {void}
 */
function showSection(section){
	var view;
    GM.renderDetailBox = null;
	switch(section){
		case 'events':
            GM.EventController.showEventPage();
            break;
		case 'adventurers':
            GM.AdventurerController.showAdventurerPage();
			break;
		case 'quests':
            GM.QuestController.showQuestPage();
			break;
		case 'home':
			GM.GuildmasterModel.getGuildmaster(showView);
            break;
        case 'facilities':
            GM.FacilityController.showFacilityPage();
            break;
        case 'scout':
            GM.ScoutController.setupScout();
            break;
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

/**
 * show the login page and setup relevant event listeners
 * @return {void}
 */
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
            GM.AccountModel.login(email, password);
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
            $('.enterButton').mouseup();
        }
    });
}

/**
 * show the signup page and setup relevant event listeners
 * @param  {string} email
 *         email entered by user
 * @param  {string} password
 *         password entered by user
 * @return {void}
 */
function setupSignupPage(email, password) {
    var submitted = false;
    $('#email').val(email);
    $('#password').val(password);
    $('#signupButton').mouseup(function() {

        var email = $('#email').val();
        var username = $('#username').val();
        var password = $('#password').val();
        var confirmPassword = $('#confirmPassword').val();

        if (email == ''){
            showSignupNullError('email');
        } else if (username == ''){
            showSignupNullError('username');
        } else if (username.length < 5){
            showUsernameTooShortError();
        } else if (username.length > 15){
            showUsernameTooLongError();
        } else if (password == '') {
            showSignupNullError('password');
        } else if (password.length < 6){
            showPasswordTooShortError();
        } else if (password != confirmPassword) { // check whether the two passwords are the same
            showDifferentPasswordError();
        }
        else {
            submitted = true;
            GM.AccountModel.signup(email, username, password);
        }
    });
}

/**
 * show the game page
 * @return {void}
 */
function showGame() {
    GM.timebar = null;
	$('#indexPage').html(gameTemplate);
	$('button').click(function(){
		var section = $(this).attr('id');
		showSection(section);
	});
	showSection('home');
    setupTimeBar();
}

/**
 * show or update the timebar
 * @return {void}
 */
function setupTimeBar(){
    GM.GuildmasterModel.getGuildmaster(function() {
        GM.EventModel.getAllEvents(function(events) {
            renderTimeBar(events, GM.GuildmasterModel.guildmaster.game_time);
        });        
    })
}

/**
 * show the forget password page and setup relevant event listeners
 * @param  {string} email
 *         email entered by user
 * @param  {string} password
 *         password entered by user
 * @return {void}
 */
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
            GM.AccountModel.sendPasswordToken(email); 
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
            showPasswordTooShortError();
        } else if (email == ''){
            showSignupNullError('email');
        } else if (password == '') {
            showSignupNullError('password');
        } else if (token == '') {
            showSignupNullError('Confirmation code');
        } else {
            GM.AccountModel.updateAccount(email, password, token);
        }
    });
}

/**
 * show the success changed password page and setup relevant event listeners
 * @return {void}
 */
function showSuccessChangePasswordPage() {
    $('#indexPage').html(resetPasswordSuccessTemplate);
    $('#goToLogin').mouseup(function() {
        setupLoginPage();
    });
}

/**
 * show the successful signup page and setup relevant event listeners
 * @return {void}
 */
function showSuccessSignupPage(email) {
	$('#indexPage').html(signupSuccessTemplate);
    setupActivateAccountButton(email);
    setupResendEmailButton(email);
}

/**
 * add event listener for the activate account button
 * @param  {string} email
 *         email entered by user
 * @return {void}
 */
function setupActivateAccountButton(email) {
    $('#activateAccount').mouseup(function() {
        var code = $('#activationCode').val();
        var email = $('#email').val();
        if (!code) {
            showAlertMessage("Please enter the activation code");
        } else {
            GM.AccountModel.activateAccount(code, email);
        }
    });
}

/**
 * add event listener for the resend email
 * @param  {string} email
 *         email entered by user
 * @return {void}
 */
function setupResendEmailButton(email) {
    $('#resendEmail').mouseup(function() {
        GM.AccountModel.resendEmail(email);
    });
}

/**
 * show the successful account activation page and setup relevant event listeners
 * @return {void}
 */
function showSuccessActivatePage() {
    $('#indexPage').html(activateSuccessTemplate);
    $('#goToLogin').mouseup(function() {
        setupLoginPage();
    });
}

/**
 * show the email not activated page and setup relevant event listeners
 * @return {void}
 */
GM.IndexController.showEmailNotActivated = function(email) {
    $('#indexPage').html(emailNotActivatedTemplate);
    setupActivateAccountButton(email);
    setupResendEmailButton(email);
}

/**
 * show the ranking page and setup relevant event listeners
 * @return {void}
 */
function showRankings() {
    GM.timebar = null;
    GM.GuildmasterModel.getAll(GM.RankingController.displayRanking);
}

/**
 * show the alert error message
 * @param  {string} message
 * @return {void}
 */
function showAlertMessage(message) {
    var alertMessage = alertMessageTemplate({'message' : message});
    $('#alert').html(alertMessage);
}


/**
 * show the session expire page and setup relevant event listeners
 * @return {void}
 */
function show401Redirect(message) {
    $('#indexPage').html(unauthorizedTemplate);
    sessionStorage.removeItem('loggedIn');
    $('#goToLogin').mouseup(function() {
        setupLoginPage();
    });
}

/**
 * logout from the game
 * @return {void}
 */
function logout() {
    GM.AccountModel.logout();
}

function showDifferentPasswordError() {
    showAlertMessage('The two password you entered are different');
}

function showWrongPasswordError() {
    showAlertMessage('The password you entered is wrong.');
}

function showWrongToken () {
    showAlertMessage('The code you entered is wrong.');
}

function showEmailTaken() {
	showAlertMessage('The email you entered to register is already taken.');
}

function showUsernameTaken() {
    showAlertMessage('The username you entered is already taken. Please try another one.');
}

function showEmailNotValid() {
    showAlertMessage('The email you entered is not valid.');
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

function showPasswordTooShortError() {
	showAlertMessage('The password must be at least 6 characters');
}

function showUsernameTooShortError() {
    showAlertMessage('The username must be at least 5 characters');
}

function showUsernameTooLongError() {
    showAlertMessage('The username must be at most 15 characters');
}

function showLoginError() {
    showAlertMessage('Some error occured during login...');
}
