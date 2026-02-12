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
    if self.layer then
        del(ParticleManager.layers[self.layer], self)    
    else
        del(ParticleManager.particles, self)    
    end
end