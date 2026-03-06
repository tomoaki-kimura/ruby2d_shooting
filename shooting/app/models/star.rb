class Star < Circle
  attr_accessor :speed

  def initialize
    super
    self.radius = 2
    self.x = rand(5..(Window.width - 5))
    self.y = 0
  end

  def self.set(stars)
    star = self.new
    star.x = rand(2..Window.width - 2)
    position = rand(0..4)
    star.color = "random"
    if position == 0 || position == 2
      star.speed = 3
      star.radius = 2
      star.color.opacity = 0.8
    else
      star.speed = 2
      star.radius = 1.5
      star.color.opacity = 0.6
    end
    stars << star
  end

  def self.move(stars)
    stars.each do |star|
      star.y += star.speed
      if star.y > Window.height
        star.remove
        stars.delete(star)
      end
    end
  end
end