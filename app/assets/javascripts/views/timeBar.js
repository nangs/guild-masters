var TIMEBAR_LEFT_PADDING = 20;
var TIMEBAR_TOP_PADDING = 16;
var MARK_RADIUS = 6;
function renderTimeBar(events, currentGameTime){
	var canvas;
	if (GM.timebar) {
		canvas = GM.timebar;
	} else {
		canvas = new fabric.Canvas('timeBar');
	}
	canvas.clear();
	var timeBar = new fabric.Line([TIMEBAR_LEFT_PADDING, TIMEBAR_TOP_PADDING, 1100, TIMEBAR_TOP_PADDING], {
		strokeWidth: 10,
		stroke: 'green'
	});

	var start = new fabric.Circle({
		top : TIMEBAR_TOP_PADDING,
		left : TIMEBAR_LEFT_PADDING,
		strokeWidth: 10,
		radius: 10,
		fill: '#fff',
		stroke: 'green'
	});

	var nextDay = Math.floor(currentGameTime / 1000 + 1) * 1000;
	var nextDayPoint = nextDay - currentGameTime + TIMEBAR_LEFT_PADDING;
	var endOfDay = new fabric.Line([nextDayPoint , TIMEBAR_TOP_PADDING - 15, nextDayPoint, TIMEBAR_TOP_PADDING + 15], {
		strokeWidth: 10,
		stroke: 'red',
		selectable: false
	});
	var endOfDayText = new fabric.Text(
		'End of the\ncurrent day',
		{
			left: nextDayPoint,
			top: TIMEBAR_TOP_PADDING + 30,
			fontSize: 14,
			stroke: 'rgb(200,100,200)'
		}
	);

	canvas.add(timeBar, start, endOfDay, endOfDayText);
	if (events.length > 0) {
		for (var e in events) {
			var eve = events[e];
			var newEndMark;
			switch (eve.type) {
				case "QuestEvent":
					renderQuestMark(eve, currentGameTime, canvas);
					break;
				case "FacilityEvent":
					renderFacilityMark(eve, currentGameTime, canvas);
					break;
				case "ScoutEvent":
					renderScoutMark(eve, currentGameTime, canvas);
					break;
				case "UpgradeEvent":
					renderUpgradeMark(eve, currentGameTime, canvas);
					break;
			}
		}	
	}
	canvas.on('mouse:move', function(e) {
		if (e.target) {
			if (!e.target.isInfoShown) {
				if (e.target.showInfo) {
					e.target.showInfo();
				}
			}
		} else {
			canvas.forEachObject(function(o) {
				if (o.removeInfo) {
					o.removeInfo();
					o.isInfoShown = false;
				}
			});
		}
		canvas.renderAll();
	});
	canvas.forEachObject(function(o) {
		o.selectable = false;
	});
	GM.timebar = canvas;
	return canvas;
}

function renderQuestMark(eve, currentGameTime, canvas) {
	var endTime = eve.end_time - currentGameTime;
	var circle = new fabric.Circle({
		top : TIMEBAR_TOP_PADDING,
		left : endTime + TIMEBAR_LEFT_PADDING,
		strokeWidth: 8,
		radius: MARK_RADIUS,
		fill: '#fff',
		stroke: 'blue'
	});
	circle.isInfoShown = false;

	circle.showInfo = function () {
		var quest = eve.quest;
		var infoText = quest.description + "\nDifficulty: " + quest.difficulty + "\nReward :" + quest.reward;
		var text = new fabric.Text(infoText, {
			left: endTime + TIMEBAR_LEFT_PADDING + 160,
			top: TIMEBAR_TOP_PADDING + 25,
			fontSize: 12,
			stroke: 'rgb(200,100,50)'
		});
		text.set('backgroundColor', 'rgb(0,200,200)');
		text.setOpacity(0.8);
		canvas.add(text);
		text.selectable = false;
		circle.isInfoShown = true;
		circle.infoText = text;
	};

	circle.removeInfo = function () {
		canvas.remove(this.infoText);
	};

	circle.selectable = false;
	canvas.add(circle);
}

function renderFacilityMark(eve, currentGameTime, canvas) {
	var endTime = eve.end_time - currentGameTime;
	var circle = new fabric.Circle({
		top : TIMEBAR_TOP_PADDING,
		left : endTime + TIMEBAR_LEFT_PADDING,
		strokeWidth: 8,
		radius: MARK_RADIUS,
		fill: '#fff',
		stroke: 'purple'
	});
	circle.isInfoShown = false;

	circle.showInfo = function () {
		var facility = eve.facility.name;
		var adventurer = eve.adventurer.name;
		var infoText = "Your adventurer\n" + adventurer +"\nis in the " + facility;
		var text = new fabric.Text(infoText, {
			left: endTime + TIMEBAR_LEFT_PADDING + 45,
			top: TIMEBAR_TOP_PADDING + 25,
			fontSize: 12,
			stroke: 'rgb(200,100,50)'
		});
		text.set('backgroundColor', 'rgb(0,200,200)');
		text.setOpacity(0.8);
		canvas.add(text);
		text.selectable = false;
		circle.isInfoShown = true;
		circle.infoText = text;
	};

	circle.removeInfo = function () {
		canvas.remove(this.infoText);
	};

	circle.selectable = false;
	canvas.add(circle);
}

function renderScoutMark(eve, currentGameTime, canvas) {
	var endTime = eve.end_time - currentGameTime;
	var circle = new fabric.Circle({
		top : TIMEBAR_TOP_PADDING,
		left : endTime + TIMEBAR_LEFT_PADDING,
		strokeWidth: 8,
		radius: MARK_RADIUS,
		fill: '#fff',
		stroke: 'yellow'
	});
	circle.isInfoShown = false;

	circle.showInfo = function () {
		var infoText = "The GuildMaster is scouting\nfor Adventurers and Quests";
		var text = new fabric.Text(infoText, {
			left: endTime + TIMEBAR_LEFT_PADDING + 70,
			top: TIMEBAR_TOP_PADDING + 15,
			fontSize: 12,
			stroke: 'rgb(200,100,50)'
		});
		text.set('backgroundColor', 'rgb(0,200,200)');
		text.setOpacity(0.8);
		canvas.add(text);
		text.selectable = false;
		circle.isInfoShown = true;
		circle.infoText = text;
	};

	circle.removeInfo = function () {
		canvas.remove(this.infoText);
	};

	circle.selectable = false;
	canvas.add(circle);
}

function renderUpgradeMark(eve, currentGameTime, canvas) {
	var endTime = eve.end_time - currentGameTime;
	var circle = new fabric.Circle({
		top : TIMEBAR_TOP_PADDING,
		left : endTime + TIMEBAR_LEFT_PADDING,
		strokeWidth: 8,
		radius: MARK_RADIUS,
		fill: '#fff',
		stroke: 'yellow'
	});
	circle.isInfoShown = false;

	circle.showInfo = function () {
		var infoText = "The GuildMaster is\n upgrading the Guild.";
		var text = new fabric.Text(infoText, {
			left: endTime + TIMEBAR_LEFT_PADDING + 50,
			top: TIMEBAR_TOP_PADDING + 15,
			fontSize: 12,
			stroke: 'rgb(200,100,50)'
		});
		text.set('backgroundColor', 'rgb(0,200,200)');
		text.setOpacity(0.8);
		canvas.add(text);
		text.selectable = false;
		circle.isInfoShown = true;
		circle.infoText = text;
	};

	circle.removeInfo = function () {
		canvas.remove(this.infoText);
	};

	circle.selectable = false;
	canvas.add(circle);
}