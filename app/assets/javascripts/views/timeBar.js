var timeBar_start_point = 20;
var timeBar_top_padding = 20;
function renderTimeBar(events, currentGameTime){
	var canvas = new fabric.Canvas('timeBar');

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
		stroke: 'red'
	});

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
		var text = new fabric.Text("Info box", {
			left: endTime + timeBar_start_point + 20,
			top: timeBar_top_padding + 16,
			fontSize: 10
		});
		text.set('backgroundColor', 'rgb(200,200,0)');
		text.setOpacity(0.5);
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