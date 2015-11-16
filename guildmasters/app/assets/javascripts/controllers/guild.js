GM.GuildController = Ember.Controller.extend();

GM.GuildController.getAllGuilds = function () {
	$.ajax({
		type: 'GET',
	    url: 'guild.json',
	    success: function(data) {
	    	GM.GuildController.guild = data;
	    }
	});
}

GM.GuildController.getAllGuilds();