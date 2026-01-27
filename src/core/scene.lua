Scene = {}
Scene.__index = Scene

function Scene:new(t)
    t = t or {}
    local tbl = copy_table(t)


    setmetatable(tbl,self)
    
    return tbl   
end

function Scene:update()
    log("Scene has no update method", "WARNING")
end

function Scene:draw()
    log("Scene has no draw method", "WARNING")
end

function Scene:enter()
    log("Scene has no enter method", "WARNING")
end