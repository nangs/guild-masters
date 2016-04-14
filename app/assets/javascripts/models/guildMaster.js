GM.GuildMaster = DS.Model.extend({
	gameTime: DS.attr('number'),
	state: DS.attr('string'),
	gold: DS.attr('number'),

	guilds: DS.hasMany('guild'),
	events: DS.hasMany('event')
});

GM.GuildmasterModel = DS.Model.extend();

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
