
function _init()
    palt(14)

    SceneManager:enter_scene(GameScene)
end

function _update()
    Camera:update()
    SceneManager:update()
end

function _draw()
    cls(7)
    Camera:draw()
    SceneManager:draw()
end