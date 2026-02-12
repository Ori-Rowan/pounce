MenuScene = Scene:new()
MenuScene.__index = MenuScene


function MenuScene:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl,self)
    
    return tbl   
end

MENU_SCENE_STATE={
    main=1,
    controls=2,
    options=3
}

function MenuScene:update()
    if self.state==MENU_SCENE_STATE.main then
        self:main_update()
    elseif self.state==MENU_SCENE_STATE.controls then
        self:controls_update()
    elseif self.state==MENU_SCENE_STATE.options then
        self:options_update()
    end
end

function MenuScene:draw()
    if self.state==MENU_SCENE_STATE.main then
        self:main_draw()
    elseif self.state==MENU_SCENE_STATE.controls then
        self:controls_draw()
    elseif self.state==MENU_SCENE_STATE.options then
        self:options_draw()
    end    
end

function MenuScene:enter()
    self.pointer = 1 
    self.state = MENU_SCENE_STATE.main

    ParticleManager:create_particle(SnowFlyParticle, {}, 50, "snowflakes")
end

function MenuScene:main_update()
    -- pointer
    local l_pointer = self.pointer
    if btnp(2) then
        self.pointer-=1
    end
    if btnp(3) then
        self.pointer+=1
    end
    self.pointer = mid(1,self.pointer,3)
    if l_pointer != self.pointer then
        sfx(3)
    end


    -- btn press
    if btnp(5) then
        sfx(4)
        if self.pointer==1 then
            log('Enter GameScene')
            SceneManager:enter_scene(GameScene)
        elseif self.pointer==2 then
            self.state = MENU_SCENE_STATE.controls
            self.players = {
                Player:new({x=22,y=50, scene=self}),
                Player:new({x=60,y=50, scene=self}),
                Player:new({x=98,y=50, scene=self}),
            }
            self.players[1].anim=cocreate(function()self.players[1]:idle_anim()end)
            self.players[2].anim=cocreate(function()self.players[2]:walk_anim()end)
            self.players[3].camera_shake_f = 0
            self.players[3].pounce_sfx = -1
            self.players[3].anim=cocreate(function()self.players[3]:pounce_anim()end)


        elseif self.pointer==3 then
            self.state = MENU_SCENE_STATE.options
        end
    end
end

function MenuScene:main_draw()
    self:draw_button(39,70,50,10,'play', self.pointer==1)
    self:draw_button(39,82,50,10,'controls', self.pointer==2)
    self:draw_button(39,94,50,10,'options', self.pointer==3)
end

function MenuScene:controls_update()
    foreach(self.players, function (p)
        if p.anim then
            coresume(p.anim)
        end
    end)

    if btnp(5) then
        sfx(4)
        self.state=MENU_SCENE_STATE.main
    end
end

function MenuScene:controls_draw()
    rectfill(5,30,123,98,6)
    rect(5,30,123,98,0)
    
    rectfill(12,40,40,68,7)
    rect(12,40,40,68,0)
    print_align_center("stand to listen", 12,72,30)
    
    rectfill(50,40,78,68,7)
    rect(50,40,78,68,0)
    print_align_center("use ⬅️⬆️➡️⬇️ to walk", 50, 72, 30)

    rectfill(88,40,116,68,7)
    rect(88,40,116,68,0)
    print_align_center("use ❎ to pounce", 88, 72, 30)
    
    rectfill(5,20,35,28,6)
    rect(5,20,35,28,0)
    print("❎ back", 7, 22, 0)

    foreach(self.players, function (p)
        p:draw()
    end)
end

function MenuScene:options_update()
    if btnp(5) then
        sfx(4)
        self.state=MENU_SCENE_STATE.main
    end
end

function MenuScene:options_draw()
    rectfill(5,30,123,98,6)
    rect(5,30,123,98,0)

     
    rectfill(5,20,35,28,6)
    rect(5,20,35,28,0)
    print("❎ back", 7, 22, 0)

    print_align_center("to be added", 10, 60, 108)

end


function MenuScene:draw_button(x,y,w,h,msg,pointer)
    if pointer then
        msg ="❎ "..msg
    end
    rectfill(x,y,x+w,y+h,6)
    rect(x,y,x+w,y+h,0)
    print_align_center(msg, x,y+h/2-2,w,0)
end