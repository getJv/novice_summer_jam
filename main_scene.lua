-- list of global variables included by other files
-- player {x:int,y:int, speed:int} from handler_player.lua
maze = {}
maze_size = 16 -- This is the max size of the maze
cell_size = 8  -- this is the cell, in this case 8x8 pixels

-- the idea is:  1's will be wall and 0's will be path
test_maze = {
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,1,0,1,0,1,1,1,1,1,1,1,0,1,1},
    {1,0,1,0,0,0,0,0,0,0,0,0,1,0,0,1},
    {1,0,1,1,1,1,1,0,1,1,1,0,1,1,0,1},
    {1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
    {1,1,1,0,1,1,1,1,1,0,1,1,1,1,0,1},
    {1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1},
    {1,0,1,1,1,1,1,0,1,0,1,0,1,1,1,1},
    {1,0,0,0,0,0,1,0,1,0,0,0,1,0,0,1},
    {1,1,1,1,1,0,1,0,1,1,1,0,1,0,1,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,1,1,1,1,1,1,1,1,1,1,1,1,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,1,1,1,1,1,1,1,1,1,1,1,1,0,1},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
}

function draw_maze()
    -- here im going by each x,y of the maze matrix
    for y = 1, maze_size do
        for x = 1, maze_size do
            -- (x - 1) is important because the array starts at 1 but the screen pixels starts at 0
            local screen_x = (x - 1) * cell_size
            local screen_y = (y - 1) * cell_size


            if maze[y][x] == 1 then -- wall condition, im using 6 as grey color
                -- the cell_size - 1 here is because the pixels at screen start at 0
                rectfill(screen_x, screen_y, screen_x + cell_size - 1, screen_y + cell_size - 1, 6)
            else
                -- path condition, im using 0 as black color
                rectfill(screen_x, screen_y, screen_x + cell_size - 1, screen_y + cell_size - 1, 0)
            end
        end
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
end
