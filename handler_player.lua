player = {x=16, y=16, speed=2}
player_have_key = false

function draw_player()
    local p_sprite = controls_inverted and 1 or 2
    -- Draw a fancy player sprite hehe
    spr(p_sprite, player.x, player.y)
end

function handle_player_movement()
    local new_x = player.x
    local new_y = player.y
    local moved = false -- will be the trigger to use the check_wall collision


    local dx, dy = 0, 0
    -- get the direction based on the pressed button
    if btn(0) then dx = -1 end  -- Left arrow
    if btn(1) then dx = 1 end   -- Right arrow
    if btn(2) then dy = -1 end  -- Up Arrow
    if btn(3) then dy = 1 end   -- Down Arrow

    -- if inverted controls glitch is active apply direction inversion
    if controls_inverted then
        dx = -dx
        dy = -dy
    end

    -- Update the new position and increasing or decreasing the x,y player pos
    if dx != 0 or dy != 0 then
        new_x = player.x + (dx * player.speed)
        new_y = player.y + (dy * player.speed)
        moved = true
    end

    -- set the new positon in the array im using at the draw pos
    if moved and not check_wall_collision(new_x, new_y) then
        player.x = new_x
        player.y = new_y
    end
end

function check_wall_collision(x, y)
    local num_rows = #maze
    local num_cols = #maze[1]

    -- Add again the +1 to fix the change bt arrays and screen indexes
    -- divide by the cell_size to find the same coords in the maze_matrix
    local grid_x = flr(x / cell_size) + 1
    local grid_y = flr(y / cell_size) + 1

    -- Avoid the player move out of the bricks
    if grid_x < 1 or grid_x > num_rows or grid_y < 1 or grid_y > num_cols then
        return true
    end

    -- collision with the key
    if maze[grid_y][grid_x] == obj_type.key then
        maze[grid_y][grid_x] = obj_type.path
        player_have_key = true
        sfx(sound.got_key)
        -- TODO: Would be cool if there is a timer for holding the key the reset
    end

    -- collision with the exit
    if maze[grid_y][grid_x] == obj_type.exit then
        if player_have_key then
            num_levels = num_levels - 1
            player_have_key = false
            if num_levels == 1 then
                credits_scene_init()
            else
                main_scene_init()
            end
            sfx(sound.new_maze)

        else
            return false -- allow cross in front of the door without key
        end

    end

    if maze[grid_y][grid_x] == obj_type.breakable_wall then
        -- TODO: add logic to breakable wall
        sfx(sound.hit_breakable)
        return true
    end


    -- if the grid pos hold value 1 so a collision happened.
    return maze[grid_y][grid_x] == obj_type.wall
end

function add_player()
    local pos = get_free_path_spot()
    player.x = pos.x
    player.x = pos.y
end


