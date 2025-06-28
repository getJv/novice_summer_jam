player = {x=16, y=16, speed=2}

function draw_player()
    -- Draw a fancy player sprite hehe
    circfill(player.x, player.y, 2, 8)
end

function handle_player_movement()
    local new_x = player.x
    local new_y = player.y

    local dx, dy = 0, 0
    -- get the direction based on the pressed button
    if btn(0) then dx = -1 end  -- Left arrow
    if btn(1) then dx = 1 end   -- Right arrow
    if btn(2) then dy = -1 end  -- Up Arrow
    if btn(3) then dy = 1 end   -- Down Arrow

  -- Update the new position and increasing or decreasing the x,y player pos
    if dx != 0 or dy != 0 then
        new_x = player.x + (dx * player.speed)
        new_y = player.y + (dy * player.speed)
    end

    -- set the new positon in the array im using at the draw pos
    player.x = new_x
    player.y = new_y

end



function main_scene_init()
    _update = main_scene_update
    _draw = main_scene_draw
    -- Set initial pos for the player
    player.x = 16
    player.y = 16

end
function main_scene_update()
    handle_player_movement()
end
function main_scene_draw()
    cls()
    draw_player()

end
