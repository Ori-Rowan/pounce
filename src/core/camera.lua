Camera = {
    shake_offset = 2,
    shake_timer = 0,
}

function Camera:shake(frames)
    self.shake_timer=frames
end

function Camera:update()
    if (self.shake_timer > 0) self.shake_timer-=1 
end

function Camera:draw()
    if self.shake_timer > 0 then
        camera(self:get_offset(), self:get_offset())
    else
        camera(0,0)
    end
end

function Camera:get_offset()
    return rnd(self.shake_offset*2) - self.shake_offset
end