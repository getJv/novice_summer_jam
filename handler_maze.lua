maze = {}
maze_size = 16 -- This is the max size of the maze
cell_size = 8  -- this is the cell, in this case 8x8 pixels
num_levels = 50
obj_type = {
    path = 0, -- empty/black
    wall = 1, -- grey
    breakable_wall = 2, -- pink
    key = 3, -- yellow
    exit = 4 -- green
}

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


            -- wall condition, im using 6 as grey color
            if maze[y][x] == obj_type.wall then
                -- the cell_size - 1 here is because the pixels at screen start at 0
                rectfill(screen_x, screen_y, screen_x + cell_size - 1, screen_y + cell_size - 1, 6)

            elseif maze[y][x] == obj_type.breakable_wall then -- wall condition, im using 14 as pink color
                rectfill(screen_x, screen_y, screen_x + cell_size - 1, screen_y + cell_size - 1, 14)

            elseif maze[y][x] == obj_type.key then -- wall condition, im using 10 as yellow color
                rectfill(screen_x, screen_y, screen_x + cell_size - 1, screen_y + cell_size - 1, 10)

            elseif maze[y][x] == obj_type.exit then -- wall condition, im using 3 as green color
                rectfill(screen_x, screen_y, screen_x + cell_size - 1, screen_y + cell_size - 1, 3)

            -- path condition, im using 0 as black color
            else
                rectfill(screen_x, screen_y, screen_x + cell_size - 1, screen_y + cell_size - 1, 0)
            end
        end
    end
end

function add_key()
    local pos = get_free_path_spot()
    maze[pos.y][pos.x] = obj_type.key
end

function add_exit()
    local pos = get_free_path_spot()
    maze[pos.y][pos.x] = obj_type.exit
end