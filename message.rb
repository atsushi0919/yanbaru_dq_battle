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
      puts red_string("#{target.name} は #{attacker.name} に倒されてしまった…")
    end
  end

  def show_party_ending(params)
    message = "#{params[:allies_leader]}"
    message += "達" if params[:allies_count] > 1
    if params[:winner]
      message += "は戦いに勝った！！"
    else
      message += "は戦いに負けてしまった…"
      message = red_string(message)
    end
    puts message
  end

  # 文字列を赤文字にする
  def red_string(string)
    "\e[31m" + string + "\e[0m"
  end
end
