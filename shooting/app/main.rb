require "./config"

fighter = Fighter.new
game_title = GameTitle.new

update do

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

show