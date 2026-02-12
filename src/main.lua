
function _init()
    palt(14)

    log(tostr(_CONFIG));
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