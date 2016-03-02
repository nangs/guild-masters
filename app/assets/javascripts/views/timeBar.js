function setupTimeBar(events, currentGameTime){
	console.log(events, currentGameTime);
	var canvas = new fabric.StaticCanvas('timeBar');
	var start_point = 20;

	var timeBar = new fabric.Line([start_point, 20, 1500, 20], {
		strokeWidth: 10,
		stroke: 'green'
	});

	var start = new fabric.Circle({
		top : 20,
		left : start_point,
		strokeWidth: 10,
		radius: 10,
		fill: '#fff',
		stroke: 'green'
	});

	canvas.add(timeBar, start);
}
