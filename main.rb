require "ruby2d"

class Worm < Circle
  attr_accessor :x_flug, :y_flug
  def initialize
    super(
      radius: 10,
      x: Window.width / 2,
      y: Window.height / 2,
      color: "green"
    )
    self.x_flug = true
    self.y_flug = false
  end
end

set width: 800, height: 600

worm_size = 20
worms = []
head = 12
tail = 10
tick = 0
speed = 1
logs = (worm_size * tail).times.map { |i| [Window.width / 2 - i * speed, Window.height / 2 + i * speed] }
status = :ready

20.times do |n|
  worm = Worm.new
  worm.x = logs[n * tail].first
  worm.y = logs[n * tail].last
  worm.radius = head if n == 0
  worms << worm
end

#p worms

update do
  worms.each_with_index do |worm, i|
    #p status
    case status
    when :ready
      #移動
      if i == 0
        if worm.x_flug
          worm.x += speed
        else
          worm.x -= speed
        end
        if worm.y_flug
          worm.y += speed
        else
          worm.y -= speed
        end
        logs.unshift([worm.x, worm.y])
        logs.pop
      else
        worm.x = logs[i * tail].first
        worm.y = logs[i * tail].last
      end
    when :game_over #ここのフラグをもう一段階増やす。messageの変数をグローバルに
      message = Text.new("game over")
      status = :ready
    end

    if i == 0
      #上壁の当たり判定
      top = worm.contains?(worm.x, 0)
      #下壁の当たり判定
      bottom = worm.contains?(worm.x, Window.height)
      #右壁の当たり判定
      right = worm.contains?(Window.width, worm.y)
      #左壁の当たり判定
      left = worm.contains?(0, worm.y)
      wall_hit = top || bottom || right || left
      if wall_hit
        status = :game_over
      end
      #自分に当たる判定
      worms[2, 18].each do |w|
        if w.contains?(worm.x, worm.y)
          status = :game_over
        end
      end

    end
  end
  tick += 1
end

on :key_down do |event|
  key = event.key
  worm = worms.first
  if worm.x_flug && worm.y_flug
    case key
    when "right"
      worm.x_flug = false
      tick = 0
    when "left"
      worm.y_flug = false
      tick = 0
    end
  elsif worm.x_flug && !worm.y_flug
    case key
    when "right"
      worm.y_flug = true
      tick = 0
    when "left"
      worm.x_flug = false
      tick = 0
    end
  elsif !worm.x_flug && worm.y_flug
    case key
    when "right"
      worm.y_flug = false
      tick = 0
    when "left"
      worm.x_flug = true
      tick = 0
    end
  elsif !worm.x_flug && !worm.y_flug
    case key
    when "right"
      worm.x_flug = true
      tick = 0
    when "left"
      worm.y_flug = true
      tick = 0
    end
  end
end

show
