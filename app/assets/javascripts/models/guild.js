GM.Guild = DS.Model.extend({
	level: DS.attr('number'),
	popularity: DS.attr('number'),

	adventurers: DS.hasMany('adventurer'),
	quests: DS.hasMany('quest'),
	facilities: DS.hasMany('facility')
});

GM.GuildModel = DS.Model.extend();

GM.GuildModel.getAllGuilds = function () {
	$.ajax({
		type: 'GET',
	    url: 'guildsessions.json',
	    success: function(data) {
	    	GM.GuildmasterModel.guildmaster.guild = data.guildsessions[0];
	    	GM.GuildmasterView = guildmasterTemplate(GM.GuildmasterModel.guildmaster);
	    }
	});
}