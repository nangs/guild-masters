GM.GuildController = Ember.Controller.extend();
GM.GuildController.postGuildID = function (guildID) {
    $.ajax({
	    type: 'POST',
	    url: 'guildsessions.json',
	    data: {
	    	guild_id : guildID
	    },
	    success: function(feedback) {
	    }
	});
}