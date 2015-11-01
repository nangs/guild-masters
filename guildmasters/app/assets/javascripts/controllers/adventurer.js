adventurers_list = {
	adventurers : [
		{
			id : 1,
			name : 'Ironman',
			hp: 10,
			max_hp: 15,
			energy: 20,
			max_energy: 30,
			attack: 10,
			defense: 20,
			vision: 10,
			state: 'free'
		},
		{
			id : 2,
			name : 'Hulk',
			hp: 12,
			max_hp: 20
		}
	]
}

Handlebars.registerPartial('adventurer',  HandlebarsTemplates['adventurer/adventurer']);
var adventurersView = HandlebarsTemplates['adventurer/adventurer_list'];
// $(function(){
// 	var view = adventurersView(adventurers_list);
// 	$('#mainContainer').html(view);
// })