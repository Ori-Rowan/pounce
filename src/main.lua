
function _init()
    palt(14)

    SceneManager:enter_scene(MenuScene)
end

function _update()
    Camera:update()
    SceneManager:update()
    ParticleManager:update()
end

function _draw()
    cls(7)
    Camera:draw()
    SceneManager:draw()
    ParticleManager:draw()
end