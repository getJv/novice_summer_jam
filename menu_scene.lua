function menu_scene_init()
    _update = menu_scene_update
    _draw = menu_scene_draw
    maze = generate_maze_recursive(8,5)
    add_key()
    add_player()
    add_breakable_wall()
    add_exit()
end

function menu_scene_update()

    if btnp(5) then  -- 5 = btn X
        main_scene_init()
    end

    if btnp(4) then  -- 5 = btn Z
        credits_scene_init()
    end
end

function menu_scene_draw()
    cls()
    draw_logo()
    draw_press_x()
    draw_press_z_to_credits()
end

function draw_press_x()
    local press_x_to_start = "press ❎ to start"
    local text_width = #press_x_to_start * char_size  -- each char have ~4 pixels with
    -- max width of PICO-8
    local x_pos = (screen_width - text_width) / 2  -- find middle screen
    local y_pos = screen_height / 2 + (cell_size*2)
    print(press_x_to_start, x_pos, y_pos ,6)
end

function draw_press_z_to_credits()
    local press_z_to_start = "press 🅾️ to credits"
    local text_width = #press_z_to_start * char_size  -- each char have ~4 pixels with
    -- max width of PICO-8
    local x_pos = (screen_width - text_width) / 2  -- find middle screen
    local y_pos = screen_height / 2 + (cell_size*3)
    print(press_z_to_start, x_pos, y_pos ,6)
end

function draw_logo()

    local num_rows = #maze
    local num_cols = #maze[1]

    -- Find middle and center of screen
    local maze_width = num_cols * cell_size
    local maze_height = num_rows * cell_size

    -- find the Offset to center the image
    local offset_x = (screen_width - maze_width) / 2
    local offset_y = (screen_height - maze_height) / 4 -- 25% of height
    draw_maze(maze,offset_x,offset_y)
    --
    offset_y = screen_height / 2 -- 50% of height
    print("broken maze!",offset_x,offset_y,6)

end


