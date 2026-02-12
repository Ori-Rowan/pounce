
function _init()
    palt(14)

    log(tostr(_CONFIG));
    SceneManager:enter_scene(MenuScene)
    ParticleManager:init_layer("snowflakes")
end

function _update()
    Camera:update()
    SceneManager:update()
    ParticleManager:update()
    ParticleManager:update("snowflakes")
end

function _draw()
    cls(7)
    Camera:draw()
    SceneManager:draw()
    ParticleManager:draw()
    ParticleManager:draw("snowflakes")
end