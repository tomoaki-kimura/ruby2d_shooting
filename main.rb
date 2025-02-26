require 'ruby2d'

set width: 600, height: 800

class Fighter < Sprite

  #default_params
  SIZE_OF_ONE_SPRITE = 15
  APPEARANCE_CHARACTER_SIZE = 30 
  DEFAULT_TOP_SPEED = 2
  ACCELERATION_OF_MOVEMENT = 5
  ONE_SECOND = 60
  FIGHTER_READY_TIME = ONE_SECOND * 2
  INVINCIBLE_TIME = ONE_SECOND * 5

  #key_config
  MOVE_UP_KEY = 'w'
  MOVE_DOWN_KEY = 's'
  MOVE_LEFT_KEY = 'a'
  MOVE_RIGHT_KEY = 'd'

  #fighter_attributes
  ATTRIBUTES = %i[
    inclination
    top_speed
    current_speed
    tick
    status
  ].freeze

  attr_accessor(*Fighter::ATTRIBUTES)

  def initialize
    size = APPEARANCE_CHARACTER_SIZE
    super('fighter.png',
      width: size,
      height: size,
      x: (Window.width - size) / 2,
      y: Window.height,
      animations: animations
    )
    self.inclination = :center
    self.top_speed = DEFAULT_TOP_SPEED
    self.current_speed = 0
    self.tick = 0
    self.status = :preparation
  end

  def standby
    case self.status
    when :preparation
      standby_motion
    end
  end

  def move(event)
    case self.status
    when :ready
    move_motion(event.key)
    accelerate_to_top_speed
    window_limit
    end
  end

  def stop(event)
    case self.status
    when :ready
      stop_motion(event.key)
    end
  end

  private

  def animations
    {
      idling: positions([0, 0], [1, 0]),
      to_up: positions([1, 0], [2, 0]),
      to_down: positions([0, 1], [1, 1]),
      to_side_slow: positions([2, 1], [2, 2]),
      to_side_fast: positions([0, 2], [1, 2] )
    }
  end

  def positions(*args)
    size = SIZE_OF_ONE_SPRITE
    args.map do |ary|
      { 
        x: ary.first * size,
        y: ary.last * size,
        width: size,
        height: size
      }
    end
  end

  def standby_motion
    speed = DEFAULT_TOP_SPEED
    standby_time = FIGHTER_READY_TIME
    up_time = standby_time.to_f / 2
    idling_motion
    if self.tick < up_time
      self.y -= speed
    elsif self.tick < standby_time
      self.y += (speed.to_f / 3)
    else
      self.status = :ready
    end
  end

  def move_motion(key)
    move_up if key == MOVE_UP_KEY
    move_down if key == MOVE_DOWN_KEY
    move_left if key == MOVE_LEFT_KEY
    move_right if key == MOVE_RIGHT_KEY
  end

  def stop_motion(key)
    up = (key == MOVE_UP_KEY)
    down = (key == MOVE_DOWN_KEY)
    left = (key == MOVE_LEFT_KEY)
    right = (key == MOVE_RIGHT_KEY) 
    if up || down || left || right
      idling_motion
      self.current_speed = 0
    end
  end

  def accelerate_to_top_speed
    difference = self.top_speed - self.current_speed
    step_speed = ACCELERATION_OF_MOVEMENT
    if difference > 0 && difference < 1
      self.current_speed = self.top_speed
    elsif self.current_speed < self.top_speed
      self.current_speed += difference / step_speed.to_f
    end
  end

  def move_up
    up_motion if inclination == :center
    self.y -= current_speed
  end

  def move_down
    down_motion if inclination == :center
    self.y += current_speed
  end

  def move_right
    right_motion
    self.inclination = :right
    self.x += current_speed
  end

  def move_left
    left_motion
    self.inclination = :left
    self.x -= current_speed
  end

  def idling_motion
    play animation: :idling, loop: true
    self.inclination = :center
  end

  def up_motion
    play animation: :to_up, loop: true
  end

  def down_motion
    play animation: :to_down, loop: true
  end

  def right_motion
    if current_speed < top_speed
      right_motion_slow
    else
      right_motion_fast
    end
  end

  def left_motion
    if current_speed < top_speed
      left_motion_slow
    else
      left_motion_fast
    end
  end

  def right_motion_slow
    play animation: :to_side_slow, loop: true, flip: :horizontal
  end

  def right_motion_fast
    play animation: :to_side_fast, loop: true, flip: :horizontal
  end

  def left_motion_slow
    play animation: :to_side_slow, loop: true
  end

  def left_motion_fast
    play animation: :to_side_fast, loop: true
  end

  def window_limit
    if touch_the_window_top?
      self.y = 0
    end
    if touch_the_window_bottom?
      self.y = Window.height - self.height
    end
    if touch_the_window_left?
      self.x = 0
    end
    if touch_the_window_right?
      self.x = Window.width - self.width
    end 
  end

  def touch_the_window_top?
    self.contains?(self.x, 0)
  end

  def touch_the_window_bottom?
    self.contains?(self.x, Window.height)
  end

  def touch_the_window_left?
    self.contains?(0, self.y)
  end

  def touch_the_window_right?
    self.contains?(Window.width, self.y)
  end
end

fighter = Fighter.new

on :key do |event|
  fighter.move(event)
end

on :key_up do |event|
  fighter.stop(event)
end

update do
  fighter.standby
  fighter.tick += 1
end

show
