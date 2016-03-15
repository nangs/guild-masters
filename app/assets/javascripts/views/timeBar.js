var timeBar_start_point = 20;
var timeBar_top_padding = 16;
function renderTimeBar(events, currentGameTime){
	var canvas;
	if (GM.timebar) {
		canvas = GM.timebar;
	} else {
		canvas = new fabric.Canvas('timeBar');
	}
	canvas.clear();
	var timeBar = new fabric.Line([timeBar_start_point, timeBar_top_padding, 1100, timeBar_top_padding], {
		strokeWidth: 10,
		stroke: 'green'
	});

	var start = new fabric.Circle({
		top : timeBar_top_padding,
		left : timeBar_start_point,
		strokeWidth: 10,
		radius: 10,
		fill: '#fff',
		stroke: 'green'
	});

	var nextDay = Math.floor(currentGameTime / 1000 + 1) * 1000;
	var nextDayPoint = nextDay - currentGameTime + timeBar_start_point;
	var endOfDay = new fabric.Line([nextDayPoint , timeBar_top_padding - 10, nextDayPoint, timeBar_top_padding + 10], {
		strokeWidth: 10,
		stroke: 'red',
		selectable: false
	});
	var endOfDayText = new fabric.Text(
		'End of the\ncurrent day',
		{
			left: nextDayPoint,
			top: timeBar_top_padding + 25,
			fontSize: 14,
			stroke: 'rgb(200,100,200)'
		}
	);

	canvas.add(timeBar, start, endOfDay);
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
		top : timeBar_top_padding,
		left : endTime + timeBar_start_point,
		strokeWidth: 8,
		radius: 8,
		fill: '#fff',
		stroke: 'blue'
	});
	circle.isInfoShown = false;

	circle.showInfo = function () {
		var quest = eve.quest;
		var infoText = quest.description + "\nDifficulty: " + quest.difficulty + "\nReward :" + quest.reward;
		var text = new fabric.Text(infoText, {
			left: endTime + timeBar_start_point + 160,
			top: timeBar_top_padding + 25,
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
		top : timeBar_top_padding,
		left : endTime + timeBar_start_point,
		strokeWidth: 8,
		radius: 8,
		fill: '#fff',
		stroke: 'purple'
	});
	circle.isInfoShown = false;

	circle.showInfo = function () {
		// var quest = eve.quest;
		// var infoText = quest.description + "\nDifficulty: " + quest.difficulty + "\nReward :" + quest.reward;
		// var text = new fabric.Text(infoText, {
		// 	left: endTime + timeBar_start_point + 160,
		// 	top: timeBar_top_padding + 25,
		// 	fontSize: 12,
		// 	stroke: 'rgb(200,100,50)'
		// });
		// text.set('backgroundColor', 'rgb(0,200,200)');
		// text.setOpacity(0.8);
		// canvas.add(text);
		// text.selectable = false;
		// circle.isInfoShown = true;
		// circle.infoText = text;
	};

	circle.removeInfo = function () {
		canvas.remove(this.infoText);
	};

	circle.selectable = false;
	canvas.add(circle);
}
