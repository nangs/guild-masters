describe("Testing frontend quest controller", function() {
    var quests = [
        {
            "id": 1,
            "difficulty": 2,
            "state": "failed",
            "reward": 298,
            "guild_id": 2,
            "monster_template_id": 5,
            "description": "A giant has been attacking our villagers for a long time. Please kill it to protect our villagers."
        },
        {
            "id": 2,
            "difficulty": 1,
            "state": "successful",
            "reward": 160,
            "guild_id": 2,
            "monster_template_id": 1,
            "description": "A slime assaulted our village. Please kill it for the villagers."
        },
        {
            "id": 3,
            "difficulty": 2,
            "state": "successful",
            "reward": 242,
            "guild_id": 2,
            "monster_template_id": 1,
            "description": "A slime has been attacking our villagers for a long time. Please kill it to protect our villagers."
        },
        {
            "id": 4,
            "difficulty": 1,
            "state": "successful",
            "reward": 109,
            "guild_id": 2,
            "monster_template_id": 5,
            "description": "A giant has become a threat to our villagers' cattle. Please help our villagers to get rid of it."
        },
        {
            "id": 5,
            "difficulty": 2,
            "state": "pending",
            "reward": 238,
            "guild_id": 2,
            "monster_template_id": 2,
            "description": "A goblin has been attacking our villagers for a long time. Please kill it to protect our villagers."
        },
        {
            "id": 6,
            "difficulty": 2,
            "state": "successful",
            "reward": 246,
            "guild_id": 2,
            "monster_template_id": 5,
            "description": "A giant has been attacking our villagers for a long time. Please kill it to protect our villagers."
        },
        {
            "id": 7,
            "difficulty": 1,
            "state": "successful",
            "reward": 138,
            "guild_id": 2,
            "monster_template_id": 5,
            "description": "A giant has been attacking our villagers for a long time. Please kill it to protect our villagers."
        },
        {
            "id": 8,
            "difficulty": 2,
            "state": "successful",
            "reward": 286,
            "guild_id": 2,
            "monster_template_id": 5,
            "description": "A giant has become a threat to our villagers' cattle. Please help our villagers to get rid of it."
        },
        {
            "id": 9,
            "difficulty": 1,
            "state": "successful",
            "reward": 193,
            "guild_id": 2,
            "monster_template_id": 4,
            "description": "A elf has been attacking our villagers for a long time. Please kill it to protect our villagers."
        },
        {
            "id": 10,
            "difficulty": 3,
            "state": "pending",
            "reward": 342,
            "guild_id": 2,
            "monster_template_id": 3,
            "description": "A skeleton has become a threat to our villagers' cattle. Please help our villagers to get rid of it."
        },
        {
            "id": 11,
            "difficulty": 2,
            "state": "assigned",
            "reward": 372,
            "guild_id": 2,
            "monster_template_id": 1,
            "description": "A slime has been attacking our villagers for a long time. Please kill it to protect our villagers."
        },
        {
            "id": 12,
            "difficulty": 2,
            "state": "pending",
            "reward": 358,
            "guild_id": 2,
            "monster_template_id": 4,
            "description": "A elf has been attacking our villagers for a long time. Please kill it to protect our villagers."
        },
        {
            "id": 13,
            "difficulty": 2,
            "state": "pending",
            "reward": 403,
            "guild_id": 2,
            "monster_template_id": 1,
            "description": "A slime has been attacking our villagers for a long time. Please kill it to protect our villagers."
        }
    ];
    
    it("filter pending quest", function() {
        var filteredQuests = GM.QuestController.filterPending(quests);
        filteredQuests.forEach(function (quest){
            expect(quest.state).not.toBe('assigned');
        });
    });
});