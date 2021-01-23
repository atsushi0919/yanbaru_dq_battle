# encoding: utf-8

module Message
  MESSAGE_SPEED = 0.5

  # 開始メッセージ
  def show_start_message(enemies)
    puts
    enemies.each do |enemy|
      puts "#{enemy.name} があらわれた！"
      sleep MESSAGE_SPEED
    end
  end

  def show_damage(damage, attacker, target)
    messages = ["#{attacker.name} の攻撃！", "#{target.name} "]
    if attacker.ally
      # 味方の攻撃
      messages[-1] += damage > 0 ? "に #{damage} のダメージを与えた！" : "にダメージを与えられなかった！"
    else
      # 敵の攻撃
      messages[-1] += damage > 0 ? "は #{damage} のダメージを受けた！" : "はひらりと身をかわした！"
    end
    messages.each do |message|
      puts message
      sleep MESSAGE_SPEED
    end
  end

  def show_knockdown(attacker, target)
    if attacker.ally
      # 敵を倒した
      puts "#{attacker.name} は #{target.name} をやっつけた！"
    else
      # 味方が倒された
      puts "\e[31m#{target.name} は #{attacker.name} に倒されてしまった…\e[0m"
    end
  end

  def show_party_ending(params)
    if params[:winner]
      # 勝利
      message = "\n#{params[:allies_leader]}"
      message += "達" if params[:allies_count] > 1
      message += "は戦いに勝った！！"
    else
      # 全滅
      message = "\n\e[31m#{params[:allies_leader]} "
      message += "達" if params[:allies_count] > 1
      message += "は戦いに負けてしまった…\e[0m"
    end
    puts message
  end
end
