# encoding: utf-8

module Message
  MESSAGE_SPEED = 0.5

  # 開始メッセージ
  def show_start_message(enemies)
    enemies.each do |enemy|
      puts "#{enemy.name} があらわれた！"
      sleep MESSAGE_SPEED
    end
  end

  def show_damage(damage, attacker, target)
    messages = ["#{attacker.name} の攻撃！", "#{target.name} "]
    if attacker.ally
      # 友軍の攻撃
      messages[-1] += damage > 0 ? "に #{damage} のダメージを与えた！" : "にダメージを与えられなかった！"
      messages << "#{attacker.name} は #{target.name} をやっつけた！！" if target.hp == 0
    else
      # 敵軍の攻撃
      messages[-1] += damage > 0 ? "は #{damage} のダメージを受けた！" : "ひらりと身をかわした！"
      messages << "\e[31m#{target.name} は #{attacker.name} に倒されてしまった！\e[0m" if target.hp == 0
    end
    messages.each do |message|
      puts message
      sleep MESSAGE_SPEED
    end
  end
end
