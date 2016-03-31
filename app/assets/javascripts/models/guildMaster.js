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
	    success: function(data) {
	    	GM.GuildmasterModel.guildmaster = data;
	    	if (func) {
	    		GM.GuildModel.getGuildInfo(func);
	    	} else {
	    		GM.GuildModel.getGuildInfo();
	    	}
	    }
	});
}
