GM.RankingController = Ember.Controller.extend();

GM.RankingController.displayRanking = function (players) {
	players.sort(GM.RankingController.compareByLevelToTime);
	var view = rankingTemplate({'users':players});
	$('#gameWindow').html(view);
}

GM.RankingController.compareByLevelToTime = function (p1, p2) {
	return p1.level / p1.game_time - p2.level / p2.game_time;
}