Particle = {}
Particle.__index = Particle

function Particle:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, self)

    return tbl
end

function Particle:update()
    log('Update unimplemented in particle', "WARNING")
end

function Particle:draw()
    log('Draw unimplemented in particle', "WARNING")
end

function Particle:die()
    del(ParticleManager.particles, self)    
end