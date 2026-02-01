SnowFlyParticle = Particle:new()
SnowFlyParticle.__index = SnowFlyParticle

function SnowFlyParticle:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, self)

    tbl.spd = rnd(0.5)+1.5
    tbl.x = flr(rnd(128))
    tbl.y = flr(rnd(128))

    return tbl    
end

function SnowFlyParticle:update()
    self.x += self.spd

    if self.x >=128 then
        self.x = 0
        self.y = flr(rnd(128))
    end
end

function SnowFlyParticle:draw()
   pset(self.x,self.y,6) 
end