-- list of global variables included by other files
-- player {x:int,y:int, speed:int} from handler_player.lua


function main_scene_init()
    _update = main_scene_update
    _draw = main_scene_draw
    -- Set initial pos for the player
    player.x = 16
    player.y = 16

end
function main_scene_update()
    handle_player_movement()
end
function main_scene_draw()
    cls()
    draw_player()

end
