glitch_timer = 180
controls_inverted = false

function update_glitches()
    -- timer Countdown
    if glitch_timer > 0 then
        glitch_timer -= 1
    end

    -- Reset the timer
    if glitch_timer <= 0 and controls_inverted then
        controls_inverted = false
        -- 60 frames is a sec adding 120 here means the next timer
        -- will be something bt 3-5 segundos
        glitch_timer = 180 + rnd(120)
    end

    -- Trigger randome glitch
    if glitch_timer <= 0 and not controls_inverted then
        trigger_random_glitch()
    end
end

function trigger_random_glitch()

    -- 1: controls_inverted
    -- 2: add a breakable wall
    -- 3: TODO: move the key position hahaha!
    -- 4: TODO: if player has the key, drop it! hahaha!
    -- 5: TODO: move the exit position
    local glitch_type = flr(rnd(2)) + 1

    if glitch_type == 1 then --
        -- Invert controls
        controls_inverted = true
        glitch_timer = 180
    elseif glitch_type == 2 then
        -- execute a new glitch
        add_breakable_wall()
        glitch_timer = 120 + rnd(180)
    end
end

function get_free_path_spot()
    local path_positions = {}

    local num_rows = #maze_menu_logo
    local num_cols = #maze_menu_logo[1]

    -- find all pos with 0
    for y = 1, num_rows do
        for x = 1, num_cols do
            if maze[y][x] == 0 then
                add(path_positions, {x = x, y = y})
            end
        end
    end

    -- if none do nothing
    if #path_positions == 0 then
        return nil
    end

    -- get an random empty pos
    local random_index_pos = flr(rnd(#path_positions)) + 1
    return path_positions[random_index_pos]
end

function add_breakable_wall()

    local pos = get_free_path_spot()

    -- Game over, no more blocks player is stuck TODO: create gameover scene
    if not pos then
        cls()
        print('all blocked... gameover haha!')
        stop()
    end

    maze[pos.y][pos.x] = obj_type.breakable_wall

end

