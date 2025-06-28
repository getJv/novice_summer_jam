glitch_timer = 180
controls_inverted = false

function update_glitches()
    -- timer Countdown
    if glitch_timer > 0 then
        glitch_timer -= 1
    end

    -- Reset the timer
    if glitch_timer <= 0 then
        controls_inverted = not controls_inverted
        -- 60 frames is a sec adding 120 here means the next timer
        -- will be something bt 3-5 segundos
        glitch_timer = 180 + rnd(120)
    end

end