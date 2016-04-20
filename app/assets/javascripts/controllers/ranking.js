GM.RankingController = Ember.Controller.extend();

GM.RankingController.displayRanking = function (players) {
	players.sort(GM.RankingController.defaultRanking);
	for (var i = 0; i < players.length; i++) {
		players[i].ranking = i + 1;
	}
	var view = rankingTemplate({'users':players});
	$('#gameWindow').html(view);
}

GM.RankingController.defaultRanking = function (p1, p2) {
	if (p2.level != p1.level) {
		return p2.level - p1.level;
	} else {
		if (p2.popularity != p1.popularity) {
			return p2.popularity - p1.popularity;
		} else {
			if (p2.gold != p1.gold) {
				return p2.gold - p1.gold;
			} else {
				return GM.RankingController.compareByLevelToTime(p1, p2);
			}
		}
	}
}

GM.RankingController.compareByLevelToTime = function (p1, p2) {
	return p2.level / p2.game_time - p1.level / p1.game_time;
}

GM.RankingController.compareByPopularityToTime = function (p1, p2) {
	return p2.popularity / p2.game_time - p1.popularity / p1.game_time;
}

GM.RankingController.compareByGoldToTime = function (p1, p2) {
	return p2.gold / p2.game_time - p1.gold / p1.game_time;
}