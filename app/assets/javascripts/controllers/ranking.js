GM.RankingController = Ember.Controller.extend();

GM.RankingController.displayRanking = function (players) {
	var view = rankingTemplate({'users':players});
	$('#gameWindow').html(view);
}