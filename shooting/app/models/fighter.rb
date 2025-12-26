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
    self.right_move if key == "d"
    self.left_move if key == "a"
    self.down_move if key == "s"
    self.up_move if key == "w"
    window_limit
  end

  private

  def up_move
    self.y -= self.speed
    self.center_image
  end

  def down_move
    self.y += self.speed
    self.center_image
  end

  def right_move
    self.x += self.speed
    self.right_image
  end

  def left_move
    self.x -= self.speed
    self.left_image
  end

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
