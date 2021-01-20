class Character
  attr_accessor :hp
  attr_reader :name, :offense, :defense

  def initialize(params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end
end
