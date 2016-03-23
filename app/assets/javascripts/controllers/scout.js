GM.ScoutController = Ember.Controller.extend();

GM.ScoutController.setupScout = function() {
	showView(scoutSetTemplate);

	var goldSlider = $("#goldSelected");
	var gold = GM.GuildmasterModel.guildmaster.gold;
	goldSlider.attr("data-slider-max", gold);
	goldSlider.slider();	
	goldSlider.on("slide", function(slideEvt) {
		$("#goldSelectedValue").html(slideEvt.value);
	});

	var timeSlider = $("#timeSelected");
	timeSlider.slider();	
	timeSlider.on("slide", function(slideEvt) {
		$("#timeSelectedValue").html(slideEvt.value);
	});

	$("#scoutAssign").mouseup(function() {
		GM.ScoutModel.scout(timeSlider.val(), goldSlider.val());
	});
}