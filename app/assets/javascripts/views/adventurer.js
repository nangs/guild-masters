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
    var angles = [];
    for (var i = 0; i < sideCount; i++){
    	var angle = i * sweep - Math.PI / 2;
    	angles.push(angle);
        var x = radius * Math.cos(angle);
        var y = radius * Math.sin(angle);
        points.push({x: x,y: y});
    }
    return [points, angles];
}

function renderAdventureDetails(adventurer) {
	var canvas;
	if (GM.renderDetailBox) {
		canvas = GM.renderDetailBox;
	} else {
		canvas = new fabric.StaticCanvas('adventurer_detail');
	}
	canvas.clear();

	var cx = 250;
	var cy = 200;
	var radius = 200;
	var points_angles = regularPolygonPoints(5, radius);
	var points = points_angles[0];
	var angles = points_angles[1]
	var attributeNames = ['Max HP', 'Max Energy', 'Attack', 'Defense', 'Vision'];
	var attributes = ['max_hp', 'max_energy', 'attack', 'defense', 'vision'];


	var border = new fabric.Polygon(points, {
		left: cx,
		top: cy,
		stroke: 'red',
		fill: 'white',
		selectable: false
	});
	canvas.add(border);


	// Draw the text representing the attributes
	for (var i = 0; i < 5; i++) {
		var px = points[i].x + cx;
		var py = points[i].y + cy;
		var line = new fabric.Line([cx, cy, px, py], {
			stroke: 'red',
			selectable: false
		});
		canvas.add(line);
		var text = new fabric.Text(attributeNames[i], {
			left: px,
			top: py,
			fontSize: 14,
			selectable: false
		});
		text.set('backgroundColor', 'white');
		canvas.add(text);
	}

	var adventurer_points = [];
	for (var i = 0; i < 5; i++) {
		var attr = attributes[i];
		var value = adventurer[attr];
		var percentage;
		if (attr != 'max_hp') {
			percentage = value / GM.max_adventurer_attributes;
		} else {
			percentage = value / GM.max_adventurer_max_hp;
		}
		var distance = Math.sqrt(percentage) * radius;
		var angle = angles[i];
        var x = distance * Math.cos(angle) + cx;
        var y = distance * Math.sin(angle) + cy + 7;
        console.log([x,y]);
        adventurer_points.push([x , y]);
	}

	for (var i = 0; i < 5; i++) {
		var p1 = adventurer_points[i];
		var p2;
		if (i == 4) {
			p2 = adventurer_points[0];
		} else {
			p2 = adventurer_points[i + 1];
		}
		var line = new fabric.Line([p1[0], p1[1], p2[0], p2[1]], {
			stroke: 'green',
			selectable: false
		});
		canvas.add(line);
	} 

	GM.renderDetailBox = canvas;
	return canvas;
}