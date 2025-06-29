
function credits_scene_init()
    _update = credits_scene_update
    _draw = credits_scene_draw
end

function credits_scene_update()

    if btnp(4) then  -- 5 = btn Z
        menu_scene_init()
    end

end

function credits_scene_draw()
    cls()
    draw_text("novice summer jam 2025-06",-5,14)
    draw_text("theme:",-3,14)
    draw_text("something is wrong",-2,14)

    draw_text("thank you for playing!",0,9)
    draw_text("developed by getjv",2,3)
    draw_text("jpmorais.com.br",3,3)

    draw_text("press 🅾️ to main menu",6,6)

end

function draw_text(text,y_offset,color)
    local text_width = #text * char_size  -- each char have ~4 pixels with
    local x_pos = (screen_width - text_width) / 2  -- find middle screen
    local y_pos = screen_height / 2 + (cell_size * y_offset )
    print(text, x_pos, y_pos ,color)
end
