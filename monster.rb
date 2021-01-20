require "./character"

class Monster < Character
  def attack(target)
    # ダメージ処理
    dice = rand(3)
    damage = [@offense + dice % 3 - target.defense / 2, 0].max
    # ダメージが0以下でも1/3の確率で1与える
    damage = 1 if damage == 0 and dice == 0
    # targetのHPがマイナスになったら0にする
    target.hp = [target.hp - damage, 0].max

    # メッセージ処理
    messages = ["#{@name} の攻撃！", "#{target.name} は"]
    messages[-1] += damage > 0 ? " #{damage} のダメージを受けた！" : "ひらりと身をかわした！"
    messages.each do |message|
      puts message
      sleep 1
    end
  end
end
