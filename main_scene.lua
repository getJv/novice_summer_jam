-- list of global variables included by other files
-- player {x:int,y:int, speed:int} from handler_player.lua
-- maze {}; maze_size,cell_size int; maze_test:[][]int  from handler_maze.lua
-- glitch_timer:int from handler_glitch

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
