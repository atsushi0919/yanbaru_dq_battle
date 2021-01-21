class Character
  attr_accessor :hp, :ally
  attr_reader :name, :offense, :defense

  def initialize(params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
    @ally = true
  end

  def attack(target_defense)
    # ダメージ計算
    dice = rand(3)
    damage = [@offense + dice - target_defense / 2, 0].max
    # ダメージが0でも1/3の確率で1与える
    damage = 1 if damage == 0 and dice == 0
    damage
  end
end
