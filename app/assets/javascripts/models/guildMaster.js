GM.GuildMaster = DS.Model.extend({
	gameTime: DS.attr('number'),
	state: DS.attr('string'),
	gold: DS.attr('number'),

	guilds: DS.hasMany('guild'),
	events: DS.hasMany('event')
});

GM.GuildmasterModel = DS.Model.extend();

/**
 * get the guildmaster for the player
 * @param  {function} func
 *         apply the function to the guildmaster obtained
 * @return {void}     
 */
GM.GuildmasterModel.getGuildmaster = function (func) {
	$.ajax({
		type: 'POST',
	    url: 'guildmaster.json',
	    data: {
	    	cmd: 'get'
	    },
	    statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(data) {
	    	if (data.msg == "success") {
		    	GM.GuildmasterModel.guildmaster = data.guildmaster;
		    	if (func) {
		    		GM.GuildModel.getGuildInfo(func);
		    	} else {
		    		GM.GuildModel.getGuildInfo();
		    	}	    		
	    	}
	    }
	});
}

/**
 * get all the guildmasters summary from the backend for ranking
 * @param  {function} func
 *         apply the function to the guildmasters
 * @return {void}    
 */
GM.GuildmasterModel.getAll = function (func) {
	$.ajax({
		type: 'POST',
	    url: 'guildmaster.json',
	    data: {
	    	cmd: 'show_all'
	    },
	    statusCode: {
			401: function (response) {
				show401Redirect(response);
			}
		},
	    success: function(data) {
	    	if (data.msg == "success") {
				func(data.users); 		
	    	}
	    }
	});
}