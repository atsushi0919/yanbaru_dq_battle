# encoding: utf-8

require "./character"

class Monster < Character
  def initialize(params)
    super(params)
    @ally = false
  end
end
