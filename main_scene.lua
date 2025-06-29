maze_ready = false
function main_scene_init()
    _update = main_scene_update
    _draw = main_scene_draw
    -- Load the maze format, using test until i code the auto generation... probably the most broken part TODO: try random generation or creat 10 maps as default...
    maze_ready = false
    maze = generate_maze_recursive(16,16)
    add_key()
    add_exit()
    add_player()

    -- random music from playlist
    local random_index = flr(rnd(#playlist)) + 1
    local selected_music = playlist[random_index]
    music(selected_music)
end

function main_scene_update()
    handle_player_movement()
    update_glitches()
end

function main_scene_draw()
    cls()
    draw_ui()
    draw_maze(maze,0,0)
    draw_player()

end
