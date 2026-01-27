SnowSplashParticle = Particle:new()
SnowSplashParticle.__index = SnowSplashParticle

function SnowSplashParticle:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, self)

    assert(tbl.x and tbl.y)

    tbl.ground_y = tbl.y - rnd(3)
    tbl.spd_y = -3-rnd(1.5)
    tbl.spd_x = rnd(2)-1
    tbl.gravity = 0.5

    return tbl 
end

function SnowSplashParticle:update()
    self.spd_y += self.gravity

    self.y += self.spd_y
    self.x += self.spd_x
    
    if self.y >= self.ground_y then
        self:die()
    end
end

function SnowSplashParticle:draw()
    pset(self.x, self.y, 6)
end