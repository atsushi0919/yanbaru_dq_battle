class Battle
  def initialize(bt_chars)
    @player = bt_chars[:pl]
    @monster = bt_chars[:ms]
  end

  def start_battle
    puts "#{@monster.name} が現れた！"
    sleep 1
    while true
      @player.attack @monster
      break
    end
  end
end
