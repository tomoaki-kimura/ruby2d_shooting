class Bullet < Circle
  ANGLE_OFFSET = [0, -15, 15, -30, 30]
  attr_accessor :speed, :angle

  def initialize
    super(
      radius: 3
    )
    self.speed = 15
    self.angle = 0
  end

  def self.set(bullets, fighter)
    bullet_size = fighter.level * 2 - 1
    bullet_size.times do |i|
      bullet = self.new
      bullet.x = fighter.x + (fighter.width / 2)
      bullet.y = fighter.y
      bullet.angle = ANGLE_OFFSET[i]
      bullets << bullet
    end
  end

  def self.move(bullets)
    bullets.each do |bullet|
      r = (bullet.angle + 90) * PI / 180
      bullet.x += cos(r) * bullet.speed
      bullet.y -= sin(r) * bullet.speed
    end
  end
end

# 角度からラジアンに変換
# r = 45.0 * PI / 180
# X方向
# cos(r)
# Y方向
# sin(r)