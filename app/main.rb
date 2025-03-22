require './config'

tick = 0
stars = []

update do
  if tick % 10 == 0
    stars << Star.new
  end
  Star.fall_down(stars)
  tick += 1
end

show