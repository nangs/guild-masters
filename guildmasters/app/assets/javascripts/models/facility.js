export default DS.Model.extend({
	level: DS.attr('number'),

	adventurers: DS.hasMany('adventurer')
});