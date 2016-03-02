function setupTimeBar(events, currentGameTime){
	console.log(events, currentGameTime);
	var canvas = new fabric.StaticCanvas('timeBar');
	
	var timeBar = new fabric.Line([0, 20, 1500, 20], {
		left: 70,
		strokeWidth: 10,
		stroke: 'green'
	});
	canvas.add(timeBar);
}
