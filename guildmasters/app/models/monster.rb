require 'monster_template.rb'
class Monster
  attr_reader :max_hp, :hp, :attack, :defense
  attr_writer :hp
  def initialize(monster_template, level)
    @max_hp = monster_template.max_hp*level
    @hp=@max_hp
    @attack = monster_template.attack*level
    @defense = monster_template.defense*level
  end

end