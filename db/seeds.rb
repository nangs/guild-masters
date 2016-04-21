# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

Account.create(email: 'admin@example.com',
               password: 'admin',
               email_confirmed: true,
               is_admin: true)


AdventurerTemplate.create([
                            { max_hp: 1000, max_energy: 1000, attack: 100, defense: 100, vision: 100 },
                            { max_hp: 1200, max_energy: 1100, attack: 110, defense: 90, vision: 70 },
                            { max_hp: 900, max_energy: 1000, attack: 100, defense: 90, vision: 120 },
                            { max_hp: 1000, max_energy: 1300, attack: 90, defense: 90, vision: 110 },
                            { max_hp: 1200, max_energy: 1000, attack: 80, defense: 120, vision: 90 }])

MonsterTemplate.create([
                         { name: 'slime', max_hp: 1000, max_energy: 800, attack: 70, defense: 70, invisibility: 100 },
                         { name: 'goblin', max_hp: 800, max_energy: 1000, attack: 80, defense: 80, invisibility: 80 },
                         { name: 'skeleton', max_hp: 800, max_energy: 1000, attack: 100, defense: 90, invisibility: 90 },
                         { name: 'elf', max_hp: 700, max_energy: 1300, attack: 110, defense: 80, invisibility: 130 },
                         { name: 'giant', max_hp: 1400, max_energy: 800, attack: 120, defense: 100, invisibility: 60 }
                       ])

QuestDescription.create([
                          { description: 'A %s assaulted our village. Please kill it for the villagers.' },
                          { description: 'A %s has been attacking our villagers for a long time. Please kill it to protect our villagers.' },
                          { description: 'A %s has become a threat to our villagers\' cattle. Please help our villagers to get rid of it.' }
                        ])

# Insert a list of possible adventurer names
AdventurerName.create([
                        { name: 'Abel Tasman' },
                        { name: "Adolf Erik Nordenskiöld" },
                        { name: 'Afonso de Albuquerque' },
                        { name: 'Alan Shepard' },
                        { name: 'Aleksey Leonov' },
                        { name: 'Alexander von Humboldt' },
                        { name: 'Alexander MacKenzie' },
                        { name: "Alexandra David-Néel" },
                        { name: 'Amelia Earhart' },
                        { name: 'Amerigo Vespucci' },
                        { name: "Andrés de Urdaneta" },
                        { name: 'Antonio Pigafetta' },
                        { name: 'Aurel Stein' },
                        { name: 'Bartolomeu Dias' },
                        { name: 'Bill Tilman' },
                        { name: "Cândido Rondon" },
                        { name: 'Charles Lindbergh' },
                        { name: 'Charles Sturt' },
                        { name: 'Cornelis de Houtman' },
                        { name: 'Cristoforo Columbo' },
                        { name: 'David Livingstone' },
                        { name: 'Davy Crockett' },
                        { name: 'Diego de Almagro' },
                        { name: 'Douglas Mawson' },
                        { name: 'Edmund Hillary' },
                        { name: 'Edwin "Buzz" Aldrin' },
                        { name: 'Erik the Red' },
                        { name: 'Ernest Shackleton' },
                        { name: "Evliya Çelebi" },
                        { name: "Ferdinand Konščak" },
                        { name: 'Ferdinand Magellan' },
                        { name: "Fernão Mendes Pinto" },
                        { name: 'Francis Drake' },
                        { name: 'Francis Younghusband' },
                        { name: 'Francisco de Almeida' },
                        { name: 'Francisco de Orellana' },
                        { name: 'Francisco Pizarro' },
                        { name: "Francisco Vázquez de Coronado" },
                        { name: 'Frederick Cook' },
                        { name: 'Fridtjof Nansen' },
                        { name: 'George Bass' },
                        { name: 'George Mallory' },
                        { name: 'George Vancouver' },
                        { name: 'Giovanni da Pian del Carpine' },
                        { name: 'Giovanni Caboto' },
                        { name: 'Giovanni da Verrazzano' },
                        { name: 'Hamilton Hume' },
                        { name: 'Hanno the Navigator' },
                        { name: 'Zheng He' },
                        { name: 'Henry the Navigator' },
                        { name: 'Henry Hudson' },
                        { name: 'Henry Morton Stanley' },
                        { name: "Hernán Cortés" },
                        { name: 'Hernando de Soto' },
                        { name: 'Ignacije Szentmartony' },
                        { name: "Ingólfur Arnarson" },
                        { name: 'Jacques Cartier' },
                        { name: 'Jacques Cousteau' },
                        { name: 'James Bruce' },
                        { name: 'James Cook' },
                        { name: 'James Augustus Grant' },
                        { name: 'James Clark Ross' },
                        { name: "Jean François de Galaup" },
                        { name: 'John Franklin' },
                        { name: 'John Glenn' },
                        { name: 'John Ledyard' },
                        { name: 'John Oxley' },
                        { name: 'John Wesley Powell' },
                        { name: 'John Hanning Speke' },
                        { name: 'John Lloyd Stephens' },
                        { name: 'John McDouall Stuart' },
                        { name: "Juan Sebastián Elcano" },
                        { name: "Juan Ponce de León" },
                        { name: 'Leif Ericson' },
                        { name: 'Louis Antoine de Bougainville' },
                        { name: 'Louis Hennepin' },
                        { name: 'Marco Polo' },
                        { name: 'Matthew Flinders' },
                        { name: 'Meriwether Lewis' },
                        { name: "Miguel López de Legazpi" },
                        { name: 'Abu Abdullah Muhammad ibn Battuta' },
                        { name: 'Mungo Park' },
                        { name: 'Neil Armstrong' },
                        { name: "Niccolò de' Conti" },
                        { name: "Pedro Álvares Cabral" },
                        { name: "Pedro Fernandes de Queirós" },
                        { name: 'Pedro Sarmiento de Gamboa' },
                        { name: "Pêro da Covilhã" },
                        { name: 'Peter Skene Ogden' },
                        { name: 'Peter Pond' },
                        { name: 'Pierre Savorgnan de Brazza' },
                        { name: 'Pytheas' },
                        { name: 'Zhang Qian' },
                        { name: 'Reinhold Messner' },
                        { name: "René-Robert Cavelier de La Salle" },
                        { name: 'Richard Francis Burton' },
                        { name: 'Richard E. Byrd' },
                        { name: 'Roald Amundsen' },
                        { name: 'Robert Bartlett' },
                        { name: 'Robert Peary' },
                        { name: 'Robert Falcon Scott' },
                        { name: "Ruy López de Villalobos" },
                        { name: 'Samuel Baker' },
                        { name: 'Samuel de Champlain' },
                        { name: 'Semyon Dezhnyov' },
                        { name: 'Sven Hedin' },
                        { name: 'Tenzing Norgay' },
                        { name: 'Teoberto Maler' },
                        { name: 'Thomas Mitchell' },
                        { name: 'Thor Heyerdahl' },
                        { name: 'Valentina Tereshkova' },
                        { name: "Vasco Núñez de Balboa" },
                        { name: 'Vasco da Gama' },
                        { name: 'Vitus Bering' },
                        { name: 'Walter Raleigh' },
                        { name: 'Willem Barentsz' },
                        { name: 'Willem Janszoon' },
                        { name: 'William Baffin' },
                        { name: 'William Clark' },
                        { name: 'William Herndon' },
                        { name: 'William Hovell' },
                        { name: 'William Edward Parry' },
                        { name: 'William Grant Stairs' },
                        { name: 'Xuanzang' },
                        { name: 'Yermak Timofeyevich' },
                        { name: 'Yuriy Gagarin' },
                        { name: 'Zebulon Pik' }])
