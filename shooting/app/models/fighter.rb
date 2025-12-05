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
    window_limit
  end

  private

  def window_limit
    top_limit
    bottom_limit
    left_limit
    right_limit
  end

  def top_limit
    if self.y < 0
      self.y = 0
    end
  end

  def bottom_limit
    if self.y > Window.height - self.height
      self.y = Window.height - self.height
    end
  end

  def left_limit
    if self.x < 0
      self.x = 0
    end
  end

  def right_limit
    if self.x > Window.width - self.width
      self.x = Window.width - self.width
    end
  end
end
