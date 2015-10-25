export default DS.Model.extend({
	gameTime: DS.attr('number'),
	state: DS.attr('string'),
	gold: DS.attr('number'),

	guilds: DS.hasMany('guild'),
	events: DS.hasMany('event')
});