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
    -- 2: TODO: resist wall added
    local glitch_type = flr(rnd(2)) + 1

    if glitch_type == 1 then --
        -- Invert controls
        controls_inverted = true
        glitch_timer = 180
    elseif glitch_type == 2 then
        -- execute a new glitch
        replace_path_with_something()
        glitch_timer = 120 + rnd(180)
    end
end

function replace_path_with_something()
    local path_positions = {}

    -- find all pos with 0
    for y = 1, maze_size do
        for x = 1, maze_size do
            if maze[y][x] == 0 then
                add(path_positions, {x = x, y = y})
            end
        end
    end

    -- if none do nothing
    if #path_positions == 0 then
        cls()
        print('all blocked... gameover haha!')
        stop()
    end

    -- get an random empty pos
    local random_index_pos = flr(rnd(#path_positions)) + 1
    local pos = path_positions[random_index_pos]

    maze[pos.y][pos.x] = 2 --


end

