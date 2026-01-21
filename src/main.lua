
function _init()
    palt(14)

    log('test')

    SceneManager:enter_scene(MenuScene)

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