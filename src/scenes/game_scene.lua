GameScene = Scene:new()
GameScene.__index = GameScene


function GameScene:new(tbl)
    tbl = tbl or {}

    setmetatable(tbl,self)
    
    return tbl   
end

function GameScene:update()
    self.player:update()
    self.clock:update()

    if self.clock.timer == 0 then
        SceneManager:enter_scene(GameOverScene, {score=self.score.value})
    end
end

function GameScene:draw()
    self.player:draw()
    self.clock:draw()
    self.score:draw()
end

function GameScene:enter()
    self.clock = Clock:new({scene=self, timer=99})
    self.score=Score:new({scene=self})
    self.rodent=Rodent:new({scene=self})
    self.player=Player:new({scene=self, x=60, y=60,})
end