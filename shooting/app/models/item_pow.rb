class ItemPow < Sprite
  attr_accessor :speed

  def initialize
    super("./app/images/item_pow.png",
      width: 30,
      height: 30
    )
    self.speed = 3
  end

  def move
    self.y += self.speed
  end

  def self.set(position, items)
    item = self.new
    item.x = position.first
    item.y = position.last
    items << item
  end

  def touch(fighter, items)
    fighter.hit_area.each do |point|
      p self.contains?(*point)
    end
  end
end
