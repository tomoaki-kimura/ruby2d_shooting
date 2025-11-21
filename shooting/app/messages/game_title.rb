class GameTitle
  attr_accessor :title, :start_message

  def initialize
    self.title = Text.new("Shooting", size: 60)
    self.title.x = (Window.width - self.title.width) / 2
    self.title.y = 300
    self.start_message = Text.new("press key 'space' to start")
  end
end