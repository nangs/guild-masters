GM.AdventurerController = Ember.Controller.extend();

/**
 * filter the list of adventurers who are alive
 * @param  {array} adventurers
 * @return {array} list of filtered adventurers
 */
GM.AdventurerController.filterAlive = function (adventurers) {
	return adventurers.filter(function(adventurer) {
		var isAlive = (adventurer.state != 'dead');
		return isAlive;
	});	
}

/**
 * filter the list of adventurers who are suitable for going to clinic
 * @param  {array} adventurers
 * @return {array} list of filtered adventurers
 */
GM.AdventurerController.filterForClinic = function (adventurers) {
	return adventurers.filter(function(adventurer) {
		var isHPLow = (adventurer.hp < adventurer.max_hp);
		var isAvailable = (adventurer.state == 'available');
		return isHPLow && isAvailable;
	});
};

/**
 * filter the list of adventurers who are suitable for going to canteen
 * @param  {array} adventurers
 * @return {array} list of filtered adventurers
 */
GM.AdventurerController.filterForCanteen = function (adventurers) {
	return adventurers.filter(function(adventurer) {
		var isHPLow = (adventurer.energy < adventurer.max_energy);
		var isAvailable = (adventurer.state == 'available');
		return isHPLow && isAvailable;
	});
};

/**
 * filter the list of adventurers who are suitable for going to quest
 * @param  {array} adventurers
 * @return {array} list of filtered adventurers
 */
GM.AdventurerController.filterForQuest = function (adventurers) {
	return adventurers.filter(function(adventurer) {
		var isReady = (adventurer.energy > 0 && adventurer.hp > 0);
		var isAvailable = (adventurer.state == 'available');
		return isReady && isAvailable;
	});
};

/**
 * search adventurer by id
 * @param  {integer} id
 * @return {adventurer}
 */
GM.AdventurerController.searchById = function (id) {
	var adventurers = GM.AdventurerModel.adventurers_list;
	for (var ad in adventurers) {
		var adventurer = adventurers[ad];
		if (adventurer.id == id) {
			return adventurer;
		}
	}
	return null;
}

/**
 * show the Adventurer Page
 * @return {void}
 */
GM.AdventurerController.showAdventurerPage = function() {
	GM.AdventurerModel.getAllAdventurers(function (data) {
	    var adventurers = GM.AdventurerController.filterAlive(data);
	    GM.AdventurerController.showAdventurerWithGraph(adventurers, adventurerSummaryTableTemplate);
	});
};

/**
 * show the adventurer attributes with graph
 * @param  {array} adventurers
 * @param  {template} tableTemplate
 *         template for rendering the table of adventurers
 * @param  {string} prependHtml
 *         HTML which can be prepend before the adventurers
 * @return {void}
 */
GM.AdventurerController.showAdventurerWithGraph = function(adventurers, tableTemplate, prependHtml) {
    if (adventurers.length == 0) {
    	showView("There is no Adventurer in your Guild, please try scouting for some Adventurers and Quests");
    }
    else {
    	var list = tableTemplate({'adventurers' : adventurers});
    	var view = adventurerDisplayTemplate();
    	if (prependHtml) {
    		showView(prependHtml + view);
    	} else{
    		showView(view);
    	}
    	$('#adventurers_list').html(list);
    	$('.adventurer_row').mouseup(function() {
    		var adventurer = GM.AdventurerController.searchById(this.id);
    		$('.adventurer_row').css('background-color', 'white');
    		renderAdventureDetails(adventurer);
    		$(this).css('background-color', 'yellow');
    	});
    	var first_id = adventurers[0].id;
    	$('#' + first_id).mouseup();
    }
};
