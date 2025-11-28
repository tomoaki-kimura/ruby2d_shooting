class Fighter < Rectangle
  attr_accessor :speed

  def initialize
    super
    self.width = 30
    self.height = 30
    self.speed = 10
    self.remove
  end

  def move(key)
    self.x += self.speed if key == "d"
    self.x -= self.speed if key == "a"
    self.y += self.speed if key == "s"
    self.y -= self.speed if key == "w"
  end
end