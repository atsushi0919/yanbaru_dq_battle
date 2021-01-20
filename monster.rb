require "./character"

class Monster < Character
  def initialize(params)
    super(params)
    @skill = "痛恨の一撃"
  end
end
