Player={}
Player.__index=Player

function Player:new(tbl)
    tbl= tbl or {}
    
    setmetatable(tbl,self)
    
    assert(tbl.x  and tbl.y and tbl.scene)
    
    tbl.dir = nil
    tbl.spd = tbl.spd or 1
    tbl.spr= 1
    
    tbl:enter_state(PLAYER_STATE.idle)
    
    return tbl
end

-- state machine

PLAYER_STATE = {
    idle = 0, 
    walk = 1,
    pounce = 2
}

function Player:update()
    -- log("Player state: "..self.state)
    if self.state == PLAYER_STATE.idle then
        self:idle() 
    elseif self.state == PLAYER_STATE.walk then
        self:walk()    
    elseif self.state == PLAYER_STATE.pounce then
        self:pounce()
    end  
    
    if self.anim then
        coresume(self.anim)
    end
end


function Player:draw()
    -- log('spr'.. self.spr)
    spr(self.spr, self.x, self.y)
end

function Player:idle()
    local listen_t_fixed = 1
    local listen_t_offset = 0.5

    self.listen_timer = self.listen_timer or seconds_to_frames(listen_t_fixed+rnd(listen_t_offset))
    if self.listen_timer > 0 then
        self.listen_timer-=1
    else
        self.scene.rodent:squeek(self:get_dist_from_rodent())
        self.listen_timer=nil
    end

    -- check other states
    if get_8d_input() then
        self:enter_state(PLAYER_STATE.walk)
    elseif btnp(4) then
        self:enter_state(PLAYER_STATE.pounce)
    end
end

function Player:walk()
    local p_dir = get_8d_input()
    -- avoid cobble stoning
    if(p_dir!=self.dir) self.x,self.y=flr(self.x),flr(self.y)
    -- move if dir
    self.dir=p_dir
    if p_dir then
        entity_movement(self)
        -- border
        self.x=mid(0,self.x,128)
        self.y=mid(0,self.y,128)
    end

    -- check other states
    if p_dir==nil then
        self:enter_state(PLAYER_STATE.idle)
    elseif btnp(4) then
        self:enter_state(PLAYER_STATE.pounce)
    end
end


function Player:pounce()
    local max_dist = 15
    local pounce_time = 1

    self.pounce_timer = self.pounce_timer or seconds_to_frames(pounce_time)
    if self.pounce_timer > 0 then
        self.pounce_timer-=1
    else
        if self:get_dist_from_rodent() < max_dist then
            sfx(2)
            self.scene.rodent:move()
            self.scene.score:add_score(100)
        end
        self:enter_state(PLAYER_STATE.idle)
    end
end

function Player:enter_state(new_state)
    self.state = new_state

    if new_state == PLAYER_STATE.idle then
        self.listen_timer=nil
        self.anim=cocreate(function()self:idle_anim()end)
    end

    if new_state == PLAYER_STATE.walk then
        self.anim=cocreate(function()self:walk_anim()end)
    end

     if new_state == PLAYER_STATE.pounce then
        self.pounce_timer=nil
        self.anim=cocreate(function()self:pounce_anim()end)
    end
end

-- utils

function Player:get_dist_from_rodent()
    return get_vector_length(get_vector_from_points(self, self.scene.rodent))
end

-- anims

function Player:idle_anim()
    while true do
        self.spr=4
        for i=0, 10 do
            yield()
        end
        self.spr=5
        for i=0, 10 do
            yield()
        end
    end
end

function Player:walk_anim()
     while true do
        self.spr=2
        for i=0, 5 do
            yield()
        end
        self.spr=3
        for i=0, 5 do
            yield()
        end
    end
end

function Player:pounce_anim()
    self.spr=5
    for i=0,6 do
        yield()
        yield()
        self.spr+=1
    end
    sfx(1)
    Camera:shake(3)
end

