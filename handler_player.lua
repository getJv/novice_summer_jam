player = {x=16, y=16, speed=2,w=6,h=6}
player_have_key = false
player_added = false
forcing = 0

function draw_player()
    local p_sprite = controls_inverted and 1 or 2
    -- Draw a fancy player sprite hehe
    spr(p_sprite, player.x, player.y)
end

function handle_player_movement()
    local new_x = player.x
    local new_y = player.y

    if btn(4) then menu_scene_init() end   -- force Restart


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
    end

    --check_collisions()

    -- set the new positon in the array im using at the draw pos
    if not check_collisions(new_x,new_y) then
        player.x = new_x
        player.y = new_y
    end
end

function cell_corners(x,y,obj_w,obj_h,cell_size)
    return {
        -- top left
        {x = flr(x / cell_size) + 1, y = flr(y / cell_size) + 1},
        -- top right
        {x = flr((x + obj_w - 1) / cell_size) + 1, y = flr(y / cell_size) + 1},
        -- bottom left
        {x = flr(x / cell_size) + 1, y = flr((y + obj_h ) / cell_size) + 1},
        -- bottom right
        {x = flr((x + obj_w ) / cell_size) + 1, y = flr((y + obj_h - 1) / cell_size) + 1}
    }
end

function check_collisions(new_x, new_y)

    local corners = cell_corners(new_x, new_y, player.w,player.h,cell_size)

    for corner in all(corners) do
        local cell_x = corner.x
        local cell_y = corner.y
        -- if inside the limit of screen
        if cell_y >= 1 and cell_y <= #maze and cell_x >= 1 and cell_x <= #maze[1] then
            -- get the cell type from maze value
            local maze_value = maze[cell_y][cell_x]

            if maze_value == obj_type.path then
                -- ignore and continue for next corner
            elseif maze_value == obj_type.wall then
                return true -- wall collision
            elseif maze_value == obj_type.breakable_wall then
                if forcing < 20 then
                    forcing = forcing + 1
                    sfx(sound.hit_breakable)
                    return true
                end
                maze[cell_y][cell_x] = obj_type.path
                forcing = 0
                -- ignore and continue for next corner
            elseif maze_value == obj_type.key then
                maze[cell_y][cell_x] = obj_type.path
                player_have_key = true
                sfx(sound.got_key)
                -- ignore and continue for next corner
            elseif maze_value == obj_type.exit then
                if player_have_key then
                    num_levels = num_levels - 1
                    player_have_key = false
                    if num_levels == 1 then
                        credits_scene_init()
                    else
                        main_scene_init()
                    end
                    sfx(sound.new_maze)
                end
                -- ignore and continue for next corner
            end
        else
            -- out of maze range
            return true
        end
    end

    -- not detected colision
    return false
end

function add_player()
    local pos = get_free_path_spot()
    local screen_x = (pos.x - 1) * cell_size
    local screen_y = (pos.y- 1) * cell_size
    player.x = screen_x
    player.y = screen_y
end


