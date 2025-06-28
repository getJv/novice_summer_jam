

function draw_ui()
    -- Indicador de glitch
    if controls_inverted then
        print("controls inverted!", 2, 2, 14)
    end

    if player_have_key then
        local text = "with the key!"
        local text_width = #text * 4  -- each char have ~4 pixels with
        local screen_width = 128      -- max width of PICO-8
        local x_pos = screen_width - text_width - 2  -- -2 of right margin
        print(text, x_pos, 2, 10)
    end

    local text = "depth:"
    local text_width = (#text + 2) * 4  -- each char have ~4 pixels with
    local screen_width = 128 -- max width of PICO-8
    local x_pos = screen_width - text_width - 2  -- -2 of right margin
    print(text .. num_levels, x_pos, 122 , 7)

    -- Next glitch info
    print("glitch in:" .. flr(glitch_timer/60 + 1), 2, 122, 7)
end