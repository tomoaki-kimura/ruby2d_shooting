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
  end
end

enemy = Enemy1.new
enemy.play(animation: :roll, loop: true)