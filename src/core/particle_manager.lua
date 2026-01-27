ParticleManager = {
    particles = {}
}

function ParticleManager:create_particle(particle, tbl, amount)
    amount = amount or 1
    for i=1, amount do   
        add(self.particles, particle:new(tbl))
    end
end

function ParticleManager:update()
    foreach(self.particles, function (p)
        p:update()
    end)
end

function ParticleManager:draw()
    foreach(self.particles, function (p)
        p:draw()
    end)
end