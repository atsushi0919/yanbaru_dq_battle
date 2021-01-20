require "./character"

class Brave < Character
  def attack(target)
    # ダメージ処理
    dice = rand(6)
    damage = @offense + dice % 3 - target.defense / 2
    # ダメージが0以下でも1/6の確率で1与える
    damage = 1 if damage <= 0 and dice == 0
    # HPがマイナスになったら0にする
    target.hp = [target.hp - damage, 0].max

    # メッセージ処理
    messages = ["#{@name} の攻撃！", "#{target.name} に "]
    messages[-1] += damage > 0 ? "#{damage} のダメージを与えた！" : "ダメージを与えられなかった！"
    messages.each do |message|
      puts message
      sleep 1
    end
  end
end
