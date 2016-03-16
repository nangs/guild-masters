GM.GuildController = Ember.Controller.extend();
GM.GuildController.postGuildID = function (guildID) {
    $.ajax({
	    type: 'POST',
	    url: 'guild_sessions.json',
	    data: {
	    	guild_id : guildID
	    },
	    success: function(feedback) {
	    }
	});
}