MenuScene = Scene:new()
MenuScene.__index = MenuScene


function MenuScene:new(t)
    t = t or {}
    local tbl = copy_table(t)

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
    -- print_align_center("use x to pounce", 10,8,30)
    -- print_align_center("use arows to walk", 50, 8, 30)
    -- print_align_center("stand still to listen", 90, 8, 30)

    
    -- rect(20,8,60,80)
end

