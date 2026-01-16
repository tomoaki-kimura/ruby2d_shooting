class Status
  attr_reader :game_status
  
  def to_title
    @game_status = :title
  end

  def to_ready
    @game_status = :ready
  end
end