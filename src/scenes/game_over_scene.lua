GameOverScene = Scene:new()
GameOverScene.__index = GameOverScene


function GameOverScene:new(tbl)
    tbl = tbl or {}

    setmetatable(tbl,self)

    assert(tbl.score)
    
    return tbl   
end


function GameOverScene:update()
    if btnp(5) then
        SceneManager:enter_scene(GameScene)
    end
end

function GameOverScene:draw()
    print("final score: "..self.score, 35, 60, 0)
    print("press ❎ to play again", 20, 70, 0)
end