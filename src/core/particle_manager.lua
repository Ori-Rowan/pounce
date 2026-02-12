ParticleManager = {
    particles = {},
    layers = {}
}

function ParticleManager:create_particle(particle, tbl, amount, layer)
    amount = amount or 1
    home = self.particles
    if layer then
        local home = self.layers[layer]
        tbl.layer = layer
    end

    for i=1, amount do   
        add(home, particle:new(tbl))
    end
end

function ParticleManager:init_layer(layer)
    self.layers[layer] = {}
end

function ParticleManager:update(layer)
    local particles = self.particles        
    if layer then
        particles = self.layers[layer]
    end
    log("updating layer: "..tostr(layer))

    foreach(particles, function (p)
        p:update()
    end)
end

function ParticleManager:draw(layer)
    local particles = self.particles        
    if layer then
        particles = self.layers[layer]
    end

    foreach(particles, function (p)
        p:draw()
    end)
end