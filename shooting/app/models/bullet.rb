class Bullet < Circle
  attr_accessor :speed

  def initialize
    super(
      radius: 3
    )
    self.speed = 15
  end

  def self.set(bullets, fighter)
    bullet = self.new
    bullet.x = fighter.x + (fighter.width / 2)
    bullet.y = fighter.y
    bullets << bullet
  end

  def self.move(bullets)
    bullets.each do |bullet|
      bullet.y -= bullet.speed
    end
  end
end

# 角度からラジアンに変換
# r = 45.0 * PI / 180
# X方向
# cos(r)
# Y方向
# sin(r)