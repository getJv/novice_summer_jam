maze = {}
cell_size = 8  -- this is the cell, in this case 8x8 pixels
num_levels = 10
obj_type = {
    path = 0,
    wall = 60,
    breakable_wall = 61,
    key = 62,
    exit = 63
}

-- https://www.integral-domain.org/lwilliams/Applets/algorithms/backtrackingmaze.php
-- https://www.youtube.com/watch?v=gBC_Fd8EE8A
function generate_maze_recursive(width, height)
    local new_maze = {}

    -- Step 1: set all as wall
    for row = 1, height do
        new_maze[row] = {}
        for col = 1, width do
            new_maze[row][col] = obj_type.wall
        end
    end

    -- step 2: start the path finder
    function carve_path(x, y)
        new_maze[y][x] = 0  -- Set entrypoint

        -- set possible directions trbl
        local directions = {{0,2},{2,0},{0,-2},{-2,0}}

        -- random away sort the directions
        for i = #directions, 2, -1 do
            local j = flr(rnd() * i) + 1
            directions[i] = directions[j]
            directions[j] = directions[i]
        end

        -- Try each direction 
        for dir in all(directions) do
            local next_x, next_y = x + dir[1], y + dir[2]

            -- is inside maze limit? and is a wall
            if next_x > 1 and next_x < width and next_y > 1 and next_y < height and new_maze[next_y][next_x] == obj_type.wall then
                new_maze[y + dir[2]/2][x + dir[1]/2] = 0  -- Replace wall for path
                carve_path(next_x, next_y)  -- Call for next coors
            end
        end
    end

    -- Entrypoint to cave
    carve_path(2, 2)
    maze_ready = true
    return new_maze
end



-- use offset as 0 if you dont need it
function draw_maze(maze_template,offset_x,offset_y)

    local num_rows = #maze_template
    local num_cols = #maze_template[1]

    -- here im going by each x,y of the maze matrix
    for y = 1, num_rows do
        for x = 1, num_cols do
            -- (x - 1) is important because the array starts at 1 but the screen pixels starts at 0
            local screen_x = (x - 1) * cell_size + offset_x
            local screen_y = (y - 1) * cell_size + offset_y

            -- wall condition
            if maze_template[y][x] == obj_type.wall then
                -- the cell_size - 1 here is because the pixels at screen start at 0
                spr(obj_type.wall, screen_x, screen_y)

            -- breakable_wall condition
            elseif maze_template[y][x] == obj_type.breakable_wall then
                spr(obj_type.breakable_wall, screen_x, screen_y)

            -- key condition
            elseif maze_template[y][x] == obj_type.key then
                spr(obj_type.key, screen_x, screen_y)

            -- exit condition
            elseif maze_template[y][x] == obj_type.exit then
                spr(obj_type.exit, screen_x, screen_y)

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