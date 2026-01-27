ScoreParticle = Particle:new()
ScoreParticle.__index = ScoreParticle


function ScoreParticle:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, self)

    assert(tbl.x and tbl.y)

    tbl.lifetime =  20
    tbl.spd = 0.5 -- vertical movement
    tbl.offset_x = -6
    tbl.offset_y = -5

    return tbl    
end

function ScoreParticle:update()
    self.y -= self.spd 

    self.lifetime -= 1
    if self.lifetime <= 0 then
        self:die()
    end
end

function ScoreParticle:draw()
    local draw_x= self.x + self.offset_x
    local draw_y= self.y + self.offset_y
    spr(17, draw_x, draw_y)
    spr(16, draw_x +5, draw_y)
    spr(16, draw_x +10, draw_y)
end