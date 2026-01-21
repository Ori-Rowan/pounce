SceneManager = {}
SceneManager.__index = SceneManager

function SceneManager:new(tbl)
    tbl = tbl or {}

    setmetatable(tbl,self)
    
    tbl.current_scene = nil

    return tbl    
end


function SceneManager:update()
    if (self.current_scene == nil) return log("No current scene", "Warning")

    self.current_scene:update()
end

function SceneManager:draw()
    if (self.current_scene == nil) return log("No current scene", "Warning")

    self.current_scene:draw()
end

function SceneManager:enter_scene(scene)
    self.current_scene = scene:new()
    self.current_scene:enter()
end