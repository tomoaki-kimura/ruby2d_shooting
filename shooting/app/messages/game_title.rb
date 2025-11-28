class GameTitle
  attr_accessor :title, :start_message

  def initialize
    self.title = Text.new("Shooting", size: 60)
    self.title.x = (Window.width - self.title.width) / 2
    self.title.y = 300
    self.start_message = Text.new("press key 'space' to start", size: 40)
    self.start_message.x = (Window.width - self.start_message.width) / 2
    self.start_message.y = 450
  end

  def add
    self.title.add
    self.start_message.add
  end

  def remove
    self.title.remove
    self.start_message.remove
  end
end