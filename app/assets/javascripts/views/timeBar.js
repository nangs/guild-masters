var timeBar_start_point = 20;
var timeBar_top_padding = 20;
function renderTimeBar(events, currentGameTime){
	console.log(events, currentGameTime);
	var canvas = new fabric.StaticCanvas('timeBar');
	
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
	console.log(nextDayPoint);
	var endOfDay = new fabric.Line([nextDayPoint , timeBar_top_padding - 10, nextDayPoint, timeBar_top_padding + 10], {
		strokeWidth: 10,
		stroke: 'red'
	});

	canvas.add(timeBar, start, endOfDay);
	for (var e in events) {
		var eve = events[e];
		var newEndCircle;
		switch (eve.type) {
			case "QuestEvent":
				newEndCircle = renderQuestCircle(eve, currentGameTime);
				break;
			case "FacilityEvent":
				newEndCircle = renderFacilityCircle(eve, currentGameTime);
				break;
		}
		canvas.add(newEndCircle);
	}
	return canvas;
}

function renderQuestCircle(eve, currentGameTime) {
	var endTime = eve.end_time - currentGameTime;
	var circle = new fabric.Circle({
		top : timeBar_top_padding,
		left : endTime + timeBar_start_point,
		strokeWidth: 10,
		radius: 10,
		fill: '#fff',
		stroke: 'blue'
	});
	return circle;
}