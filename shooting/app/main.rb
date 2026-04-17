require "./config"

@status = Status.new
fighter = Fighter.new
game_title = GameTitle.new

bullets = []
stars = []
items = []

tick = 0

update do
  Star.set(stars) if tick % 10 == 0
  Star.move(stars)

  case @status.game_status
  when :title
  when :start
    fighter.opening_action
    Bullet.move(bullets)
    ItemPow.set([0, 0], items) if tick % 180 == 0
    items.each { |item| item.move }
    items.each do |item|
      item.touch(fighter, items)
    end
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
    if @status.game_status == :title
      game_title.remove
      fighter.status = :clear
      @status.to_start
      fighter.add
    end
  when "j"
    if fighter.status == :ready
      Bullet.set(bullets, fighter)
    end
  end
end

on :key_up do |event|
  key = event.key
  fighter.nutral(key)
end

show