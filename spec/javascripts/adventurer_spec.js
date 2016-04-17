describe("Testing frontend adventurer controller", function() {
    var adventurersString = '[{"id":1,"hp":1178,"max_hp":1368,"energy":36,"max_energy":120,"attack":106,"defense":140,"vision":102,"state":"resting","guild_id":2,"name":"Pêro da Covilhã"},{"id":2,"hp":76,"max_hp":1263,"energy":132,"max_energy":132,"attack":150,"defense":127,"vision":125,"state":"available","guild_id":2,"name":"Matthew Flinders"},{"id":3,"hp":464,"max_hp":1053,"energy":0,"max_energy":112,"attack":116,"defense":102,"vision":102,"state":"available","guild_id":2,"name":"William Hovell"},{"id":4,"hp":1081,"max_hp":1081,"energy":65,"max_energy":128,"attack":124,"defense":108,"vision":123,"state":"available","guild_id":2,"name":"Yermak Timofeyevich"},{"id":5,"hp":0,"max_hp":1189,"energy":0,"max_energy":125,"attack":120,"defense":110,"vision":115,"state":"dead","guild_id":2,"name":"Francisco Pizarro"},{"id":6,"hp":2589,"max_hp":2589,"energy":127,"max_energy":127,"attack":228,"defense":195,"vision":152,"state":"available","guild_id":2,"name":"James Cook"},{"id":7,"hp":2592,"max_hp":2592,"energy":129,"max_energy":129,"attack":173,"defense":254,"vision":193,"state":"available","guild_id":2,"name":"Matthew Flinders"}]';
    var adventurers = JSON.parse(adventurersString);
    
    it("filter alive adventurers", function() {
        var filteredAdventurers = GM.AdventurerController.filterAlive(adventurers);
        filteredAdventurers.forEach(function (adv){
            expect(adv.state).not.toBe('dead');
        });
    });

    it("filter adventurers for going to clinic", function() {
        var filteredAdventurers = GM.AdventurerController.filterForClinic(adventurers);
        filteredAdventurers.forEach(function (adv){
            expect(adv.state).toBe('available');
            expect(adv.hp).toBeLessThan(adv.max_hp);
        });
    });

    it("filter adventurers for going to canteen", function() {
        var filteredAdventurers = GM.AdventurerController.filterForCanteen(adventurers);
        filteredAdventurers.forEach(function (adv){
            expect(adv.state).toBe('available');
            expect(adv.energy).toBeLessThan(adv.max_energy);
        });
    });

    it("filter adventurers for going to quest", function() {
        var filteredAdventurers = GM.AdventurerController.filterForQuest(adventurers);
        filteredAdventurers.forEach(function (adv){
            expect(adv.state).toBe('available');
            expect(0).toBeLessThan(adv.energy);
            expect(0).toBeLessThan(adv.hp);
        });
    });
});