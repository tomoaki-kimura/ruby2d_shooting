class Background < Circle
  def initialize
    super
    self.radius = 2
    self.x = rand(5..(Window.width - 5))
    self.y = 0
  end
end

Background.new