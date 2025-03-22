class Star < Circle
  attr_reader :speed

  def initialize
    super
    z_index = rand(1..2)
    self.radius = 1
    self.x = rand(1..Window.width)
    self.y = 0
    @speed = z_index * 1.2
  end

  def self.fall_down(stars)
    stars.each do |star|
      star.y += star.speed
      star.color = "random"
      if star.y >= Window.height
        star.remove
        stars.delete(star)
      end
    end
    p stars.size
  end
end