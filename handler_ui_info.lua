

function draw_ui()
    -- Indicador de glitch
    if controls_inverted then
        local text = "controls inverted!"
        local x, y = 2, 2
        local text_width = #text * 4
        local text_height = 6
        rectfill(x, y, x + text_width - 1, y + text_height - 1, 0)
        print(text, x, y, 14)

    end

    if player_have_key then
        local text = "with the key!"
        local text_width = #text * 4  -- each char have ~4 pixels width
        local text_height = 6         -- altura padrão do texto
        local screen_width = 128      -- max width of PICO-8
        local x_pos = screen_width - text_width - 2  -- -2 for right margin
        rectfill(x_pos, 2, x_pos + text_width - 1, 2 + text_height - 1, 0)
        print(text, x_pos, 2, 10)

    end

    -- Depth counter (right)
    local depth_text = "depth:" .. num_levels
    local depth_width = #depth_text * 4
    local screen_width = 128
    local depth_x = screen_width - depth_width - 2
    local text_height = 6
    rectfill(depth_x, 122, depth_x + depth_width - 1, 122 + text_height - 1, 0)
    print(depth_text, depth_x, 122, 7)

    -- Glitch info (left)
    local glitch_text = "glitch in:" .. flr(glitch_timer/60 + 1)
    local glitch_width = #glitch_text * 4
    rectfill(2, 122, 2 + glitch_width - 1, 122 + text_height - 1, 0)
    print(glitch_text, 2, 122, 7)

end