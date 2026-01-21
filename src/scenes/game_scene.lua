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
end

function GameScene:draw()
    self.player:draw()
    self.clock:draw()
    self.score:draw()
end

function GameScene:enter()
    self.clock = Clock:new({scene=self, timer=90})
    self.score=Score:new({scene=self})
    self.rodent=Rodent:new({scene=self})
    self.player=Player:new({scene=self, x=64, y=64,})
end