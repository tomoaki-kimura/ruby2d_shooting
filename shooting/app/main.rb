require "./config"

fighter = Fighter.new
game_title = GameTitle.new

bullets = []

tick = 0

update do
  fighter.opening_action
  #次回弾を動かすメソッドに作り替える
  bullets.each do |bullet|
    bullet.y -= bullet.speed
  end
  tick += 1
end

on :key do |event|
  key = event.key
  case fighter.status
  when :ready
    fighter.move(key)
  end
end

on :key_down do |event|
  key = event.key
  case key
  when "space"
    game_title.remove
    fighter.status = :clear
    fighter.add
  when "j"
    Bullet.set(bullets, fighter)
  end
end

on :key_up do |event|
  key = event.key
  fighter.nutral(key)
end

show