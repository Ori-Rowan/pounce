Clock={}
Clock.__index = Clock

function Clock:new(t)
    t = t or {}
    local tbl = copy_table(t)


    setmetatable(tbl, self)

    assert(tbl.timer)
    
    tbl:set_timer(tbl.timer)

    return tbl
end

function Clock:update()
    if (self.timer > 0) self.timer -= 1
end

function Clock:draw()
    local seconds = frame_to_seconds(self.timer)
    local digit_10 = flr(seconds/10)
    local digit_1 = flr(seconds-digit_10*10)
    local sprite_address=16

    spr(sprite_address+digit_10, 5,6)
    spr(sprite_address+digit_1, 12,6)
end


function Clock:set_timer(seconds)
    self.timer = seconds_to_frames(seconds)
end