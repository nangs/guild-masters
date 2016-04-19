GM.RankingController = Ember.Controller.extend();

GM.RankingController.displayRanking = function (players) {
	players.sort(GM.RankingController.compareByLevelToTime);
	for (var i = 0; i < players.length; i++) {
		players[i].ranking = i + 1;
	}
	var view = rankingTemplate({'users':players});
	$('#gameWindow').html(view);
}

GM.RankingController.compareByLevelToTime = function (p1, p2) {
	return p1.level / p1.game_time - p2.level / p2.game_time;
}

GM.RankingController.compareByPopularityToTime = function (p1, p2) {
	return p1.popularity / p1.game_time - p2.popularity / p2.game_time;
}

GM.RankingController.compareByGoldToTime = function (p1, p2) {
	return p1.gold / p1.game_time - p2.gold / p2.game_time;
}