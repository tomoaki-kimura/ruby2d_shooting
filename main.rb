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

class GameOver
  attr_accessor :title, :message

  def initialize
    self.title = Text.new("game over", size: 50, x: 300, y: 100)
    self.message = Text.new("press key 'R' to restart", size: 30, x: 250, y: 300)
    self.title.remove
    self.message.remove
  end
end

set width: 800, height: 600

worm_size = 10
worms = []
head = 12
tail = 10
tick = 0
speed = 2
p logs = (worm_size * speed).times.map { |i| [Window.width / 2 - i , Window.height / 2 + i] }
p logs.size
status = :ready
game_over = GameOver.new

worm_size.times do |n|
  worm = Worm.new
  worm.x = logs[n * speed].first
  worm.y = logs[n * speed].last
  worm.radius = head if n == 0
  worms << worm
end

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
        worm.x = logs[i * speed].first
        worm.y = logs[i * speed].last
      end
    when :game_over
      game_over.title.add
      game_over.message.add
      status = :stop
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
      worms[3, worm_size - 3].each do |w|
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
  case status
  when :ready
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
  when :stop
    if key == "r"
      game_over.title.remove
      game_over.message.remove
      logs = (worm_size * speed).times.map { |i| [Window.width / 2 - i , Window.height / 2 + i] }
      worms.each_with_index do |worm, n|
        worm.x = logs[n * speed].first
        worm.y = logs[n * speed].last
        worm.x_flug = true
        worm.y_flug = false
      end
      status = :ready
    end
  end
end

show
