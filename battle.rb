class Battle
  def initialize(bt_chars)
    @player = bt_chars[:pl]
    @monster = bt_chars[:ms]
  end

  def start_battle
    puts "#{@monster.name}が現れた！"
    while true
      p "test"
      break
    end
  end
end
