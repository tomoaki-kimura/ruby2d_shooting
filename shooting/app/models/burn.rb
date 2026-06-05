class Burn < Sprite
  def initialize(x, y)
    super("./app/images/burn.png",
      width: 30,
      height: 30,
      time: 100,
      animations: {
        bomb: [
          { width: 0, height: 0, x: 0, y: 0 },
          { width: 15, height: 15, x: 0, y: 0 },
          { width: 15, height: 15, x: 15, y: 0 },
          { width: 15, height: 15, x: 0, y: 15 },
          { width: 15, height: 15, x: 15, y: 15 }
        ]
      }
    )
    self.x = x - self.width / 2
    self.y = y - self.height / 2
    self.play(animation: :bomb)
  end
end

Burn.new(100, 100)