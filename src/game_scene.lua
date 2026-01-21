GameScene = Scene:new()
GameScene.__index = GameScene


function GameScene:new(tbl)
    tbl = tbl or {}

    setmetatable(tbl,self)
    
    return tbl   
end

function GameScene:update()
    self.player:update()
    self.game_state:update()
end

function GameScene:draw()
    self.player:draw()
    self.game_state:draw()
end

function GameScene:enter()
    self.game_state=GameState:new({scene=self, timer=90})
    self.rodent=Rodent:new({scene=self})
    self.player=Player:new({scene=self, x=64, y=64,})
end