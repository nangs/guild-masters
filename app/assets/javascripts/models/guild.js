GM.Guild = DS.Model.extend({
	level: DS.attr('number'),
	popularity: DS.attr('number'),

	adventurers: DS.hasMany('adventurer'),
	quests: DS.hasMany('quest'),
	facilities: DS.hasMany('facility')
});

GM.GuildModel = DS.Model.extend();

/**
 * get all the guilds from the database (only one guild in the current version)
 * @param  {function} func
 *         apply this input function to the guild
 * @return {void}     
 */
GM.GuildModel.getAllGuilds = function (func) {
	$.ajax({
		type: 'POST',
	    url: 'guild_sessions.json',
	    data: {
	    	cmd: 'get'
	    },
	    statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(feedback) {
	    	var guild = feedback.guilds[0];
            GM.GuildmasterModel.guildmaster.guild = guild;
	    	GM.GuildmasterView = guildmasterTemplate(GM.GuildmasterModel.guildmaster);
	    	GM.GuildModel.postGuildID(guild.id);
	    	if (func) {
	    		func(GM.GuildmasterView);
	    	}
	    }
	});
}

/**
 * Post the if of the current guild to the backend for session tracking
 * @param  {integer} guildID
 *         the id of the guild
 * @return {void}      
 */
GM.GuildModel.postGuildID = function (guildID) {
    $.ajax({
	    type: 'POST',
	    url: 'guild_sessions.json',
	    data: {
	    	cmd: 'create',
	    	guild_id : guildID
	    },
	    statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(feedback) {
	    }
	});
}

/**
 * get the guild infoomation for the current guild
 * @param  {function} func
 *         apply the function to the info obtained
 * @return {void}    
 */
GM.GuildModel.getGuildInfo = function (func) {
    $.ajax({
	    type: 'POST',
	    url: 'guild.json',
	    data: {
	    	cmd: 'get',
	    },
	    statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(feedback) {
	    	console.log(feedback);
	    	GM.GuildmasterModel.guildmaster.guild = feedback.guild;
	    	GM.max_adventurer_max_hp = feedback.guild.max_adventurer_max_hp;
	    	GM.max_adventurer_attributes = feedback.guild.max_adventurer_attributes;
	    	GM.GuildmasterView = guildmasterTemplate(GM.GuildmasterModel.guildmaster);
	    	if (func) {
	    		func(GM.GuildmasterView);
	    	}
	    }
	});
}

/**
 * Upgrade the guild
 * @return {void}
 */
GM.GuildModel.upgrade = function () {
    $.ajax({
	    type: 'POST',
	    url: 'events.json',
	    data: {
	    	cmd: 'create_guild_upgrade_event',
	    },
	    statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(feedback) {
	    	if (feedback.msg == 'success') {
	    		console.log(feedback);
	    		showView(guildUpgradingTemplate(feedback));
	    		GM.GuildmasterModel.getGuildmaster();
	    		setupTimeBar();
	    	} else {
	    		console.log(feedback);
	    	}
	    }
	});
}