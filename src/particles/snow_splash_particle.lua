SnowSplashParticle = Particle:new()
SnowSplashParticle.__index = SnowSplashParticle

function SnowSplashParticle:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, self)

    assert(tbl.x and tbl.y)

    tbl.first_frame  = true
    tbl.lifetime =  12
    tbl.start_y = tbl.y
    tbl.spd_y = -3-rnd(1)
    tbl.spd_x = rnd(2)-1
    tbl.gravity = 0.5

    return tbl 
end

function SnowSplashParticle:update()
    if self.first_frame then
        self.first_frame = false
    else
        self.spd_y += self.gravity

        self.y += self.spd_y
        self.x += self.spd_x
        
        self.lifetime -= 1
        if self.y >= self.start_y then
            self:die()
        end
    end
end

function SnowSplashParticle:draw()
    pset(self.x, self.y, 6)
end