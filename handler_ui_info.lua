

function draw_ui()
    -- Indicador de glitch
    if controls_inverted then
        print("controls inverted!", 2, 2, 14)
    end

    -- Next glitch info
    print("glitch in: " .. flr(glitch_timer/60 + 1), 2, 122, 7)
end