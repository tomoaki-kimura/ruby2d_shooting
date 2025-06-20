require "ruby2d"

c = Text.new("DVD", x: 100, y: 100, size: 50)
spd = 3
x_flug = true
y_flug = true

update do
  if x_flug
    c.x += spd
  else
    c.x -= spd
  end

  if y_flug
    c.y += spd
  else
    c.y -= spd
  end

  if c.contains?(Window.width, c.y)
    x_flug = false
    c.color = "random"
  end
  if c.contains?(0, c.y)
    x_flug = true
    c.color = "random"
  end
  if c.contains?(c.x, 0)
    y_flug = true
    c.color = "random"
  end
  if c.contains?(c.x, Window.height)
    y_flug = false
    c.color = "random"
  end
end

on :key_down do |e|
  if e.key == "space"
    spd = spd * (-1)
  end
end

show