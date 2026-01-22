Rodent={}
Rodent.__index=Rodent

function Rodent:new(tbl)
    tbl= tbl or {}

    setmetatable(tbl, self)
    
    assert(tbl.scene)

    tbl.x=60
    tbl.y=60

    tbl.min_move_offset = 30
    tbl.border = 8
    
    tbl:move()

    return tbl
end

function Rodent:move()

    local last_pos = {x=self.x, y=self.y}
    local new_pos = {x=self:get_random_pos(), y=self:get_random_pos()}
    
    while get_vector_length(get_vector_from_points(last_pos, new_pos)) < 30 do
        new_pos.x=self:get_random_pos()
        new_pos.y=self:get_random_pos()
    end
    
    -- log('last pos: '..last_pos.x..","..last_pos.y)
    -- log('new pos: '..new_pos.x..","..new_pos.y)
    -- log('distance from last pos '..tostring(get_vector_length(get_vector_from_points(last_pos, new_pos))))

    self.x=new_pos.x
    self.y=new_pos.y
end

function Rodent:squeek(dist)
    local volume = 7 - flr(dist / 15)
    log("Distance: "..dist)
    log("Squek vol: "..volume)
    change_sfx_volume(0, volume)
    sfx(0)    
end

function Rodent:get_random_pos()
    return self.border+flr(rnd(129-self.border))
end