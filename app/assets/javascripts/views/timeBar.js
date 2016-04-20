var TIMEBAR_LEFT_PADDING = 20;
var TIMEBAR_TOP_PADDING = 16;
var MARK_RADIUS = 6;
var MARK_STROKE_WIDTH = 6;
var INFO_BACKGROUND_COLOR = 'rgb(200, 200, 255)';
var INFO_TEXT_COLOR = 'rgb(50, 80, 50)';
var TIMEBAR_COLOR = 'rgb(100, 255, 100)';
var END_OF_DAY_COLOR = 'rgb(50, 100, 50)';
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
		stroke: TIMEBAR_COLOR
	});

	var start = new fabric.Circle({
		top : TIMEBAR_TOP_PADDING,
		left : TIMEBAR_LEFT_PADDING,
		strokeWidth: 10,
		radius: 10,
		fill: '#fff',
		stroke: TIMEBAR_COLOR
	});

	var nextDay = Math.floor(currentGameTime / 1000 + 1) * 1000;
	var nextDayPoint = nextDay - currentGameTime + TIMEBAR_LEFT_PADDING;
	var endOfDay = new fabric.Line([nextDayPoint , TIMEBAR_TOP_PADDING - 10, nextDayPoint, TIMEBAR_TOP_PADDING + 10], {
		strokeWidth: 10,
		stroke: END_OF_DAY_COLOR,
		selectable: false
	});
	var endOfDayText = new fabric.Text(
		'End of the\ncurrent day',
		{
			left: nextDayPoint,
			top: TIMEBAR_TOP_PADDING + 30,
			fontSize: 14,
			stroke: END_OF_DAY_COLOR
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
			removeShowInfo(canvas);
			if (!e.target.isInfoShown) {
				if (e.target.showInfo) {
					e.target.showInfo();
				}
			}
		} else {
			removeShowInfo(canvas);
		}
		canvas.renderAll();
	});
	canvas.forEachObject(function(o) {
		o.selectable = false;
	});
	GM.timebar = canvas;
	return canvas;
}

function removeShowInfo(canvas) {
	canvas.forEachObject(function(o) {
		if (o.removeInfo) {
			o.removeInfo();
			o.isInfoShown = false;
		}
	});
}

function renderQuestMark(eve, currentGameTime, canvas) {
	var endTime = eve.end_time - currentGameTime;
	var circle = new fabric.Circle({
		top : TIMEBAR_TOP_PADDING,
		left : endTime + TIMEBAR_LEFT_PADDING,
		strokeWidth: MARK_STROKE_WIDTH,
		radius: MARK_RADIUS,
		fill: '#fff',
		stroke: 'rgb(50, 100, 255)'
	});
	circle.isInfoShown = false;

	circle.showInfo = function () {
		var quest = eve.quest;
		var infoText = quest.description + "\nDifficulty: " + quest.difficulty + "\nReward :" + quest.reward;
		var text = new fabric.Text(infoText, {
			left: endTime + TIMEBAR_LEFT_PADDING,
			top: TIMEBAR_TOP_PADDING + 25,
			fontSize: 12,
			stroke: INFO_TEXT_COLOR
		});
		text.left = endTime + TIMEBAR_LEFT_PADDING + text.currentWidth / 2;
		text.set('backgroundColor', INFO_BACKGROUND_COLOR);
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
		strokeWidth: MARK_STROKE_WIDTH,
		radius: MARK_RADIUS,
		fill: '#fff',
		stroke: 'rgb(250, 100, 250)'
	});
	circle.isInfoShown = false;

	circle.showInfo = function () {
		var facility = eve.facility.name;
		var adventurer = eve.adventurer.name;
		var infoText = "Your adventurer\n" + adventurer +"\nis in the " + facility;
		var text = new fabric.Text(infoText, {
			left: endTime + TIMEBAR_LEFT_PADDING,
			top: TIMEBAR_TOP_PADDING + 25,
			fontSize: 12,
			stroke: INFO_TEXT_COLOR
		});
		text.left = endTime + TIMEBAR_LEFT_PADDING + text.currentWidth / 2;
		text.set('backgroundColor', INFO_BACKGROUND_COLOR);
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
		strokeWidth: MARK_STROKE_WIDTH,
		radius: MARK_RADIUS,
		fill: '#fff',
		stroke: 'rgb(255, 200, 100)'
	});
	circle.isInfoShown = false;

	circle.showInfo = function () {
		var infoText = "The GuildMaster is scouting\nfor Adventurers and Quests";
		var text = new fabric.Text(infoText, {
			left: endTime + TIMEBAR_LEFT_PADDING,
			top: TIMEBAR_TOP_PADDING + 15,
			fontSize: 12,
			stroke: INFO_TEXT_COLOR
		});
		text.left = endTime + TIMEBAR_LEFT_PADDING + text.currentWidth / 2;
		text.set('backgroundColor', INFO_BACKGROUND_COLOR);
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
		strokeWidth: MARK_STROKE_WIDTH,
		radius: MARK_RADIUS,
		fill: '#fff',
		stroke: 'rgb(255, 200, 100)'
	});
	circle.isInfoShown = false;

	circle.showInfo = function () {
		var infoText = "The GuildMaster is\n upgrading the Guild.";
		var text = new fabric.Text(infoText, {
			left: endTime + TIMEBAR_LEFT_PADDING,
			top: TIMEBAR_TOP_PADDING + 15,
			fontSize: 12,
			stroke: INFO_TEXT_COLOR
		});
		text.left = endTime + TIMEBAR_LEFT_PADDING + text.currentWidth / 2;
		text.set('backgroundColor', INFO_BACKGROUND_COLOR);
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