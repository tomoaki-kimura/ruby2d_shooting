class Status
  attr_reader :game_status

  def initialize
    self.to_title
  end
  
  def to_title
    @game_status = :title
  end

  def to_start
    @game_status = :start
  end
end