Handlebars.registerPartial('adventurer',  HandlebarsTemplates['adventurer/adventurer']);
Handlebars.registerHelper('isAssigned', function(state, options){
	if(state == 'assigned' || state == 'resting') {
		return options.fn(this);
	}
	return options.inverse(this);
});
Handlebars.registerHelper('isDead', function(state, options){
	if(state == 'dead') {
		return options.fn(this);
	}
	return options.inverse(this);
});
var adventurerTemplate = HandlebarsTemplates['adventurer/adventurer'];
var adventurersListTemplate = HandlebarsTemplates['adventurer/adventurer_list'];
var adventurerNewTemplate = HandlebarsTemplates['adventurer/adventurer_new'];
var adventurersTableTemplate = HandlebarsTemplates['adventurer/adventurer_table'];
var adventurerSummaryTableTemplate = HandlebarsTemplates['adventurer/adventurer_summary_table'];
var adventurerNewButton = HandlebarsTemplates['adventurer/adventurer_get']();
var adventurerAssignTemplate = HandlebarsTemplates['adventurer/adventurer_assign'];
var adventurerDisplayTemplate = HandlebarsTemplates['adventurer/adventurer_display'];

function regularPolygonPoints(sideCount, radius){
    var sweep = Math.PI * 2 / sideCount;
    var points = [];
    for (var i = 0; i < sideCount; i++){
    	var angle = i * sweep - Math.PI / 2;
        var x = radius * Math.cos(angle);
        var y = radius * Math.sin(angle);
        points.push({x: x,y: y});
    }
    return points;
}

function renderAdventureDetails(adventurer) {
	var canvas;
	console.log(GM.renderDetailBox);
	if (GM.renderDetailBox) {
		canvas = GM.renderDetailBox;
	} else {
		canvas = new fabric.Canvas('adventurer_detail');
	}
	canvas.clear();

	var cx = 250;
	var cy = 200;
	var points=regularPolygonPoints(5, 200);

	var polygon = new fabric.Polygon(points, {
		left: cx,
		top: cy,
		stroke: 'red',
		fill: 'white',
		selectable: false
	});
	canvas.add(polygon);

	GM.renderDetailBox = canvas;
	return canvas;
}