require "./character"

class Brave < Character
  def initialize(params)
    super(params)
    @ally = true
  end
end
