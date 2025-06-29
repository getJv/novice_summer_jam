
maze_menu_logo = {
    {1,1,1,1,1,1,1,1},
    {1,0,2,0,1,0,3,1},
    {1,0,1,0,1,0,1,1},
    {1,0,1,0,0,0,4,1},
    {1,0,1,1,1,1,1,1},
}
-- TODO: create credit scene
-- TODO: duplicated function try use one one
function draw_maze_menu(maze_template,offset_x,offset_y)

    local num_rows = #maze_menu_logo
    local num_cols = #maze_menu_logo[1]

    -- here im going by each x,y of the maze matrix
    for y = 1, num_rows do
        for x = 1, num_cols do
            -- (x - 1) is important because the array starts at 1 but the screen pixels starts at 0
            local screen_x = (x - 1) * cell_size + offset_x
            local screen_y = (y - 1) * cell_size + offset_y



            -- wall condition, im using 6 as grey color
            if maze_template[y][x] == obj_type.wall then
                -- the cell_size - 1 here is because the pixels at screen start at 0
                rectfill(screen_x, screen_y, screen_x + cell_size - 1, screen_y + cell_size - 1, 6)

            elseif maze_template[y][x] == obj_type.breakable_wall then -- wall condition, im using 14 as pink color
                rectfill(screen_x, screen_y, screen_x + cell_size - 1, screen_y + cell_size - 1, 14)

            elseif maze_template[y][x] == obj_type.key then -- wall condition, im using 10 as yellow color
                rectfill(screen_x, screen_y, screen_x + cell_size - 1, screen_y + cell_size - 1, 10)

            elseif maze_template[y][x] == obj_type.exit then -- wall condition, im using 3 as green color
                rectfill(screen_x, screen_y, screen_x + cell_size - 1, screen_y + cell_size - 1, 3)

                -- path condition, im using 0 as black color
            else
                rectfill(screen_x, screen_y, screen_x + cell_size - 1, screen_y + cell_size - 1, 0)
            end
        end
    end
end

function menu_scene_init()
    _update = menu_scene_update
    _draw = menu_scene_draw
end

function menu_scene_update()

    if btnp(5) then  -- 5 = btn X
        main_scene_init()
    end
end

function menu_scene_draw()
    cls()
    draw_logo()
    draw_press_x()
end

function draw_press_x()
    local press_x_to_start = "press ❎ to start"
    local text_width = #press_x_to_start * char_size  -- each char have ~4 pixels with
    -- max width of PICO-8
    local x_pos = (screen_width - text_width) / 2  -- find middle screen
    local y_pos = screen_height / 2 + (cell_size*2)
    print(press_x_to_start, x_pos, y_pos ,6)
end

function draw_logo()

    local num_rows = #maze_menu_logo
    local num_cols = #maze_menu_logo[1]

    -- Find middle and center of screen
    local maze_width = num_cols * cell_size
    local maze_height = num_rows * cell_size

    -- find the Offset to center the image
    local offset_x = (screen_width - maze_width) / 2
    local offset_y = (screen_height - maze_height) / 4 -- 25% of height
    draw_maze_menu(maze_menu_logo,offset_x,offset_y)
    --
    offset_y = screen_height / 2 -- 50% of height
    print("broken maze!",offset_x,offset_y)

end


