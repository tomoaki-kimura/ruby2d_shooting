class Fighter < Sprite
  attr_accessor :speed

  def initialize
    super("app/images/fighter.png")
    self.width = 30
    self.height = 30
    self.clip_width = 15
    self.clip_height = 15
    #self.flip_sprite(:horizontal)
    self.speed = 10
    self.remove
    p self.methods
  end

  def move(key)
    self.x += self.speed if key == "d"
    self.x -= self.speed if key == "a"
    self.y += self.speed if key == "s"
    self.y -= self.speed if key == "w"
    window_limit
  end

  private

  def center_image
    self.clip_x = 0
    self.flip_sprite(nil)
  end

  def right_image
    self.clip_x = 15
    self.flip_sprite(nil)
  end

  def left_image
    self.clip_x = 15
    self.flip_sprite(:horizontal)
  end

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
