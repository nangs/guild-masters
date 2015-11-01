GM.Adventurer = DS.Model.extend({
	name: DS.attr('string'),
	hp: DS.attr('number'),
	max_hp: DS.attr('number'),
	energy: DS.attr('number'),
	max_energy: DS.attr('number'),
	attack: DS.attr('number'),
	defense: DS.attr('number'),
	vision: DS.attr('number'),
	state: DS.attr('string'),

	guild: DS.belongsTo('guild'),
	quest: DS.belongsTo('quest'),
	facility: DS.belongsTo('facility')
});