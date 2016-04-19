describe("Testing frontend event controller", function() {
    var events = [
		{
			"event_id": 1,
			"type": "QuestEvent",
			"quest_event_id": 8,
			"start_time": 2740,
			"end_time": 2993,
			"quest": {
				"id": 1,
				"difficulty": 2,
				"state": "failed",
				"reward": 298,
				"guild_id": 2,
				"monster_template_id": 5,
				"description": "A giant has been attacking our villagers for a long time. Please kill it to protect our villagers."
			},
			"adventurers": [
				{
					"id": 5,
					"hp": 0,
					"max_hp": 1189,
					"energy": 0,
					"max_energy": 125,
					"attack": 120,
					"defense": 110,
					"vision": 115,
					"state": "dead",
					"guild_id": 2,
					"name": "Francisco Pizarro"
				}
			]
		},
		{
			"event_id": 2,
			"type": "QuestEvent",
			"quest_event_id": 1,
			"start_time": 867,
			"end_time": 1018,
			"quest": {
				"id": 2,
				"difficulty": 1,
				"state": "successful",
				"reward": 160,
				"guild_id": 2,
				"monster_template_id": 1,
				"description": "A slime assaulted our village. Please kill it for the villagers."
			},
			"adventurers": [
				{
					"id": 1,
					"hp": 1178,
					"max_hp": 1368,
					"energy": 36,
					"max_energy": 120,
					"attack": 106,
					"defense": 140,
					"vision": 102,
					"state": "resting",
					"guild_id": 2,
					"name": "Pêro da Covilhã"
				}
			]
		},
		{
			"event_id": 3,
			"type": "QuestEvent",
			"quest_event_id": 7,
			"start_time": 2740,
			"end_time": 2985,
			"quest": {
				"id": 3,
				"difficulty": 2,
				"state": "successful",
				"reward": 242,
				"guild_id": 2,
				"monster_template_id": 1,
				"description": "A slime has been attacking our villagers for a long time. Please kill it to protect our villagers."
			},
			"adventurers": [
				{
					"id": 1,
					"hp": 1178,
					"max_hp": 1368,
					"energy": 36,
					"max_energy": 120,
					"attack": 106,
					"defense": 140,
					"vision": 102,
					"state": "resting",
					"guild_id": 2,
					"name": "Pêro da Covilhã"
				},
				{
					"id": 4,
					"hp": 1081,
					"max_hp": 1081,
					"energy": 65,
					"max_energy": 128,
					"attack": 124,
					"defense": 108,
					"vision": 123,
					"state": "available",
					"guild_id": 2,
					"name": "Yermak Timofeyevich"
				}
			]
		},
		{
			"event_id": 4,
			"type": "QuestEvent",
			"quest_event_id": 2,
			"start_time": 867,
			"end_time": 992,
			"quest": {
				"id": 4,
				"difficulty": 1,
				"state": "successful",
				"reward": 109,
				"guild_id": 2,
				"monster_template_id": 5,
				"description": "A giant has become a threat to our villagers\' cattle. Please help our villagers to get rid of it."
			},
			"adventurers": [
				{
					"id": 2,
					"hp": 76,
					"max_hp": 1263,
					"energy": 132,
					"max_energy": 132,
					"attack": 150,
					"defense": 127,
					"vision": 127,
					"state": "assigned",
					"guild_id": 2,
					"name": "Matthew Flinders"
				}
			]
		},
		{
			"event_id": 5,
			"type": "QuestEvent",
			"quest_event_id": 3,
			"start_time": 1018,
			"end_time": 1245,
			"quest": {
				"id": 6,
				"difficulty": 2,
				"state": "successful",
				"reward": 246,
				"guild_id": 2,
				"monster_template_id": 5,
				"description": "A giant has been attacking our villagers for a long time. Please kill it to protect our villagers."
			},
			"adventurers": [
				{
					"id": 2,
					"hp": 76,
					"max_hp": 1263,
					"energy": 132,
					"max_energy": 132,
					"attack": 150,
					"defense": 127,
					"vision": 127,
					"state": "assigned",
					"guild_id": 2,
					"name": "Matthew Flinders"
				},
				{
					"id": 3,
					"hp": 464,
					"max_hp": 1053,
					"energy": 0,
					"max_energy": 112,
					"attack": 116,
					"defense": 102,
					"vision": 102,
					"state": "available",
					"guild_id": 2,
					"name": "William Hovell"
				}
			]
		},
		{
			"event_id": 6,
			"type": "QuestEvent",
			"quest_event_id": 5,
			"start_time": 1740,
			"end_time": 1865,
			"quest": {
				"id": 7,
				"difficulty": 1,
				"state": "successful",
				"reward": 138,
				"guild_id": 2,
				"monster_template_id": 5,
				"description": "A giant has been attacking our villagers for a long time. Please kill it to protect our villagers."
			},
			"adventurers": [
				{
					"id": 4,
					"hp": 1081,
					"max_hp": 1081,
					"energy": 65,
					"max_energy": 128,
					"attack": 124,
					"defense": 108,
					"vision": 123,
					"state": "available",
					"guild_id": 2,
					"name": "Yermak Timofeyevich"
				}
			]
		},
		{
			"event_id": 7,
			"type": "QuestEvent",
			"quest_event_id": 4,
			"start_time": 1740,
			"end_time": 1966,
			"quest": {
				"id": 8,
				"difficulty": 2,
				"state": "successful",
				"reward": 286,
				"guild_id": 2,
				"monster_template_id": 5,
				"description": "A giant has become a threat to our villagers\' cattle. Please help our villagers to get rid of it."
			},
			"adventurers": [
				{
					"id": 2,
					"hp": 76,
					"max_hp": 1263,
					"energy": 132,
					"max_energy": 132,
					"attack": 150,
					"defense": 127,
					"vision": 127,
					"state": "assigned",
					"guild_id": 2,
					"name": "Matthew Flinders"
				},
				{
					"id": 5,
					"hp": 0,
					"max_hp": 1189,
					"energy": 0,
					"max_energy": 125,
					"attack": 120,
					"defense": 110,
					"vision": 115,
					"state": "dead",
					"guild_id": 2,
					"name": "Francisco Pizarro"
				}
			]
		},
		{
			"event_id": 8,
			"type": "QuestEvent",
			"quest_event_id": 6,
			"start_time": 1740,
			"end_time": 1906,
			"quest": {
				"id": 9,
				"difficulty": 1,
				"state": "successful",
				"reward": 193,
				"guild_id": 2,
				"monster_template_id": 4,
				"description": "A elf has been attacking our villagers for a long time. Please kill it to protect our villagers."
			},
			"adventurers": [
				{
					"id": 1,
					"hp": 1178,
					"max_hp": 1368,
					"energy": 36,
					"max_energy": 120,
					"attack": 106,
					"defense": 140,
					"vision": 102,
					"state": "resting",
					"guild_id": 2,
					"name": "Pêro da Covilhã"
				}
			]
		},
		{
			"event_id": 9,
			"type": "QuestEvent",
			"quest_event_id": 9,
			"start_time": 3925,
			"end_time": 4156,
			"quest": {
				"id": 11,
				"difficulty": 2,
				"state": "assigned",
				"reward": 372,
				"guild_id": 2,
				"monster_template_id": 1,
				"description": "A slime has been attacking our villagers for a long time. Please kill it to protect our villagers."
			},
			"adventurers": [
				{
					"id": 2,
					"hp": 76,
					"max_hp": 1263,
					"energy": 132,
					"max_energy": 132,
					"attack": 150,
					"defense": 127,
					"vision": 127,
					"state": "assigned",
					"guild_id": 2,
					"name": "Matthew Flinders"
				},
				{
					"id": 7,
					"hp": 2592,
					"max_hp": 2592,
					"energy": 129,
					"max_energy": 129,
					"attack": 173,
					"defense": 254,
					"vision": 195,
					"state": "assigned",
					"guild_id": 2,
					"name": "Matthew Flinders"
				}
			],
			"description": "A slime has been attacking our villagers for a long time. Please kill it to protect our villagers.",
			"adventurer_names": "Matthew Flinders, Matthew Flinders"
		},
		{
			"event_id": 10,
			"type": "FacilityEvent",
			"facility_event_id": 2,
			"start_time": 3803,
			"end_time": 3925,
			"facility": {
				"id": 3,
				"level": 2,
				"name": "clinic",
				"capacity": 3,
				"guild_id": 2
			},
			"adventurer": {
				"id": 4,
				"hp": 1081,
				"max_hp": 1081,
				"energy": 65,
				"max_energy": 128,
				"attack": 124,
				"defense": 108,
				"vision": 123,
				"state": "available",
				"guild_id": 2,
				"name": "Yermak Timofeyevich"
			},
			"gold_spent": 100
		},
		{
			"event_id": 11,
			"type": "FacilityEvent",
			"facility_event_id": 3,
			"start_time": 3925,
			"end_time": 3982,
			"facility": {
				"id": 3,
				"level": 2,
				"name": "clinic",
				"capacity": 3,
				"guild_id": 2
			},
			"adventurer": {
				"id": 1,
				"hp": 1178,
				"max_hp": 1368,
				"energy": 36,
				"max_energy": 120,
				"attack": 106,
				"defense": 140,
				"vision": 102,
				"state": "resting",
				"guild_id": 2,
				"name": "Pêro da Covilhã"
			},
			"gold_spent": 48,
			"description": "Your adventurer is in the clinic",
			"adventurer_names": "Pêro da Covilhã"
		},
		{
			"event_id": 12,
			"type": "FacilityEvent",
			"facility_event_id": 1,
			"start_time": 3719,
			"end_time": 3803,
			"facility": {
				"id": 4,
				"level": 2,
				"name": "canteen",
				"capacity": 4,
				"guild_id": 2
			},
			"adventurer": {
				"id": 2,
				"hp": 76,
				"max_hp": 1263,
				"energy": 132,
				"max_energy": 132,
				"attack": 150,
				"defense": 127,
				"vision": 127,
				"state": "assigned",
				"guild_id": 2,
				"name": "Matthew Flinders"
			},
			"gold_spent": 64
		},
		{
			"event_id": 13,
			"type": "ScoutEvent",
			"scout_event_id": 1,
			"start_time": 0,
			"end_time": 867,
			"gold_spent": 0
		},
		{
			"event_id": 14,
			"type": "ScoutEvent",
			"scout_event_id": 2,
			"start_time": 1018,
			"end_time": 1740,
			"gold_spent": 0
		},
		{
			"event_id": 15,
			"type": "ScoutEvent",
			"scout_event_id": 3,
			"start_time": 2993,
			"end_time": 3719,
			"gold_spent": 714
		},
		{
			"event_id": 16,
			"type": "UpgradeEvent",
			"upgrade_event_id": 1,
			"start_time": 1740,
			"end_time": 2740,
			"gold_spent": 500,
			"guild": {
				"id": 2,
				"level": 2,
				"popularity": 29,
				"guildmaster_id": 2
			}
		}
	];
    var gameTime = 3925;
    it("filter future events", function() {
        var filteredEvents = GM.EventController.filterFuture(events);
        filteredEvents.forEach(function (eve){
            expect(gameTime).toBeLessThan(eve.end_time);
        });
    });
});