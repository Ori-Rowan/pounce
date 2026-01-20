
function _init()
    palt(7,true)
    palt(0)


    scene= {}
    scene.game_state=GameState:new({scene=scene, timer=90})
    scene.rodent=Rodent:new({scene=scene})
    scene.player=Player:new({scene=scene, x=64, y=64,})


end

function _update()
    scene.player:update()
    scene.game_state:update()
end

function _draw()
    cls(7)
    scene.player:draw()
    scene.game_state:draw()
end