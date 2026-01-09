require "./config"

fighter = Fighter.new
game_title = GameTitle.new

tick = 0

update do
  fighter.opening_action
  tick += 1
  fighter.tick += 1
end

on :key do |event|
  key = event.key
  fighter.move(key)
end

on :key_down do |event|
  key = event.key
  case key
  when "space"
    game_title.remove
    fighter.add
  end
end

on :key_up do |event|
  key = event.key
  fighter.nutral(key)
end

show