class Enemy1 < Sprite
  attr_accessor :speed

  def initialize
    super("./app/images/enemy_1.png",
      width: 30,
      height: 30,
      animations: {
        roll: [
          { width: 15, height: 15, x: 0, y: 0 },
          { width: 15, height: 15, x: 15, y: 0 },
          { width: 15, height: 15, x: 0, y: 15 },
          { width: 15, height: 15, x: 15, y: 15 }
        ]
      }
    )
    self.x = rand(0..(Window.width - self.width))
    self.y = 0 - self.height
    self.play(animation: :roll, loop: true)
    self.speed = 3
  end

  def move(enemies)
    self.y += self.speed
    if self.y > Window.height
      self.remove
      enemies.delete(self)
    end
  end
end