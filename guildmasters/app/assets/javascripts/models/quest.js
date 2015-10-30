var Quest = DS.Model.extend({
	difficulty: DS.attr('number'),
	state: DS.attr('string'),
	reward: DS.attr('number'),
	description: DS.attr('string'),

	adventurers: DS.hasMany('adventurer')
});