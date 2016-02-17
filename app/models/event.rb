class Event < ActiveRecord::Base
  

  def assign_quest(quest,start_time)
    @start_time = start_time
    @end_time = start_time + quest.difficulty*100
    @gold_spent = 0
    @type = "quest"  
  end
end
