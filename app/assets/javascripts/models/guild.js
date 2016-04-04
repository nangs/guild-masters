GM.Guild = DS.Model.extend({
	level: DS.attr('number'),
	popularity: DS.attr('number'),

	adventurers: DS.hasMany('adventurer'),
	quests: DS.hasMany('quest'),
	facilities: DS.hasMany('facility')
});

GM.GuildModel = DS.Model.extend();

GM.GuildModel.getAllGuilds = function (func) {
	$.ajax({
		type: 'POST',
	    url: 'guild_sessions.json',
	    data: {
	    	cmd: 'get'
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

GM.GuildModel.postGuildID = function (guildID) {
    $.ajax({
	    type: 'POST',
	    url: 'guild_sessions.json',
	    data: {
	    	cmd: 'create',
	    	guild_id : guildID
	    },
	    success: function(feedback) {
	    }
	});
}

GM.GuildModel.getGuildInfo = function (func) {
    $.ajax({
	    type: 'POST',
	    url: 'guild.json',
	    data: {
	    	cmd: 'get',
	    },
	    success: function(feedback) {
	    	console.log(feedback);
	    	GM.GuildmasterModel.guildmaster.guild = feedback;
	    	GM.GuildmasterView = guildmasterTemplate(GM.GuildmasterModel.guildmaster);
	    	if (func) {
	    		func(GM.GuildmasterView);
	    	}
	    }
	});
}

GM.GuildModel.upgrade = function () {
    $.ajax({
	    type: 'POST',
	    url: 'events.json',
	    data: {
	    	cmd: 'create_guild_upgrade_event',
	    },
	    success: function(feedback) {
	    	if (feedback.msg == 'success') {
	    		showView(guildUpgradingTemplate({'guild' : feedback}));
	    	} else {
	    		console.log(feedback);
	    	}
	    }
	});
}