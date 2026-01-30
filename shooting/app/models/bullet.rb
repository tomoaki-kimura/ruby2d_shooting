class Bullet < Circle
  attr_accessor :speed

  def initialize
    super(
      radius: 3
    )
    self.speed = 5
  end

  def self.set(bullets, fighter)
    bullet = self.new
    bullet.x = fighter.x + (fighter.width / 2)
    bullet.y = fighter.y
    bullets << bullet
  end
end
