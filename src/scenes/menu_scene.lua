MenuScene = Scene:new()
MenuScene.__index = MenuScene


function MenuScene:new(tbl)
    tbl = tbl or {}

    setmetatable(tbl,self)
    
    return tbl   
end

function MenuScene:update()
    if btnp(5) then
        log('Enter GameScene')
        SceneManager:enter_scene(GameScene)
    end
end

function MenuScene:draw()
    print("press ❎ to start", 32,70,0)
end