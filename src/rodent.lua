Rodent={}
Rodent.__index=Rodent

function Rodent:new(tbl)
    tbl= tbl or {}

    setmetatable(tbl, self)
    
    assert(tbl.scene)
    
    tbl:move()

    return tbl
end

function Rodent:move()
    self.x=flr(rnd(128))
    self.y=flr(rnd(128))
end

function Rodent:squeek(dist)
    local volume = 7 - flr(dist / 15)
    log("Distance: "..dist)
    log("Squek vol: "..volume)
    change_sfx_volume(0, volume)
    sfx(0)    
end