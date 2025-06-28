-- list of global variables included by other files
-- player {x:int,y:int, speed:int} from handler_player.lua
-- maze {}; maze_size,cell_size int; maze_test:[][]int  from handler_maze.lua

glitch_timer = 180

function draw_ui()
    -- Timer do próximo glitch
    print("glitch in: " .. flr(glitch_timer/60 + 1), 2, 122, 7)
end

function update_glitches()
    -- timer Countdown
    if glitch_timer > 0 then
        glitch_timer -= 1
    end

    -- Reset the timer
    if glitch_timer <= 0 then
        -- 60 frames is a sec adding 120 here means the next timer
        -- will be something bt 3-5 segundos
        glitch_timer = 180 + rnd(120)
    end

end



function main_scene_init()
    _update = main_scene_update
    _draw = main_scene_draw
    -- Set initial pos for the player
    player.x = 16
    player.y = 16
    -- Load the maze format, using test until i code the auto generation... problably the most broken part
    maze = test_maze
end

function main_scene_update()
    handle_player_movement()
end

function main_scene_draw()
    cls()
    draw_maze()
    draw_player()
    draw_ui()
    update_glitches()
end
