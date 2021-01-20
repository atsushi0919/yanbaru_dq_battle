class Battle
  @@phase = 0
  def initialize(battle_table)
    @characters = [battle_table[:player], battle_table[:monster]]
    @member = @characters.size
  end

  def start
    puts "#{@characters[-1].name} があわられた！"
    sleep 0.5

    # 戦闘開始
    while true
      attacker_idx = @@phase % @member
      target_idx = (@@phase + 1) % @member
      @characters[attacker_idx].attack(@characters[target_idx])
      
      # 双方の攻撃が終わったとき、またはターゲットが倒れた場合HPを表示する
      if @@phase % 2 == 1 or @characters[target_idx].hp <= 0
        line ="*=*=*=*=*=*=*=*=*=*=*"
        puts line
        @characters.each do |character|
          puts "【#{character.name}】HP: #{character.hp}"
        end
        puts line
      end

      # ターゲットがノックダウンならバトルを終了してループを抜ける
      if @characters[target_idx].hp <= 0
        ending(attacker_idx)
        break
      end  
      @@phase += 1
    end
  end

  def ending(winner_idx)
    # 改行
    puts
    # 勇者の勝ち
    if winner_idx == 0
      puts "#{@characters[winner_idx].name} は #{@characters[(winner_idx + 1) % @member].name} をやっつけた！！"
    # 勇者の負け
    else
      puts "\e[31m#{@characters[0].name} は倒されてしまった！\e[0m"
    end
    # 改行
    puts
  end
end
