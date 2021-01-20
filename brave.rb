require "./character"

class Brave < Character
  def attack(target)
    # ダメージにランダム要素
    dice = rand(6)
    damage = [@offense + dice % 3 - target.defense / 2, 0].max
    # ダメージが0でも1/6の確率で1与える
    damage = 1 if damage == 0 and dice == 0
    target.hp = [target.hp - damage, 0].max
    
    # msg
    msg = ["#{@name} の 攻撃！", "#{target.name} に "]
    msg << damage > 0 ? "#{damage} のダメージを与えた！" : "ダメージを与えられなかった！"

    end
  end
end
