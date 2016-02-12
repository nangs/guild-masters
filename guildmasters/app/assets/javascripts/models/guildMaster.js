GM.GuildMaster = DS.Model.extend({
	gameTime: DS.attr('number'),
	state: DS.attr('string'),
	gold: DS.attr('number'),

	guilds: DS.hasMany('guild'),
	events: DS.hasMany('event')
});

GM.GuildmasterModel = DS.Model.extend();

GM.GuildmasterModel.getGuildmaster = function () {
	$.ajax({
		type: 'GET',
	    url: 'guildmaster.json',
	    success: function(data) {
	    	GM.GuildmasterModel.guildmaster = data;
	    	GM.GuildModel.getAllGuilds();

	    }
	});
}
