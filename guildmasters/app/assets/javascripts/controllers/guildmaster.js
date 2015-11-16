GM.GuildmasterController = Ember.Controller.extend();

GM.GuildmasterController.getGuildmaster = function () {
	$.ajax({
		type: 'GET',
	    url: 'guildmaster.json',
	    success: function(data) {

	    }
	});
}

GM.GuildmasterController.getGuildmaster();