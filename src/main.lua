
function _init()
    palt(7,true)
    palt(0)


    scene_manager = SceneManager:new()

    scene_manager:enter_scene(GameScene)
end

function _update()
    scene_manager:update()
end

function _draw()
    cls(7)
    scene_manager:draw()
end