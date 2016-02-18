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
	    success: function(feedback) {
	    	var guild = feedback.guildsessions[0];
            GM.GuildmasterModel.guildmaster.guild = guild;
            console.log(feedback);
	    	GM.GuildmasterView = guildmasterTemplate(GM.GuildmasterModel.guildmaster);
	    	GM.GuildController.postGuildID(guild.id);
	    }
	});
}