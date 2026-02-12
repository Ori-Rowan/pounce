-- START OF config.p8.lua
-- priority: -10

_CONFIG = _CONFIG or {}

_CONFIG.oris_toolbox = _CONFIG.oris_toolbox or {}

-- set default values for oris_toolbox config
function _CONFIG.oris_toolbox.init(_ENV)
    -- if log file should clear when game runs
    log_clear_on_start = log_clear_on_start ~= false
    -- where the log is stored
    log_dir = log_dir or "/log"
end

_CONFIG.oris_toolbox:init()
-- END OF config.p8.lua

-- START OF general\logging_lib.lua
-- priority: -2

printh("["..time().."][INFO]: logging start", _CONFIG.oris_toolbox.log_dir,  _CONFIG.oris_toolbox.log_clear_on_start)

---Saves log file based on _CONFIG.oris_toolbox.log_dir.
---@param string msg
---@param string level="INFO"
function log(msg, level)
    level = level or "INFO"
    log_text= "["..time().."]["..level.."]: "..msg
    printh(log_text, _CONFIG.oris_toolbox.log_dir)    
end


-- END OF general\logging_lib.lua

-- START OF general\entity_behaviour.lua
-- priority: -1

---Applies movement logic to an entity table with spd (number of units to move) and dir (point on circle [0,1) where 0 is right).
---@param table {number spd, number dir}
function entity_movement(e)
	local d=get_vector_from_angle(e.dir)
	e.x+=d.x*e.spd
	e.y+=d.y*e.spd
end


-- END OF general\entity_behaviour.lua

-- START OF general\input_lib.lua
-- priority: -1

---Returns direction, point on a circle [0,1) where 0 is right, based on the player input ⬅️⬆️➡️⬇️ for normalized 8d input.
---@returns number direction [0,1)
function get_8d_input()
	-- get dir angle from input
	local dirs,a={0.5,0,nil,0.25,0.375,0.125,0.25,0.75,0.625,0.875,0.75,nil,0.5,0},0
	for i=0,3 do
		a+=btn(i) and 2^i or 0
	end
	return dirs[a]
end


-- END OF general\input_lib.lua

-- START OF general\math_lib.lua
-- priority: -1

---Returns the number of digits infront of decimal point of a given number.
---@param number num
---@return number digits
function get_digits(num)
    num = abs(flr(num))
    if (num < 10) return 1

    local digits = 0
    while num > 0 do
        num = flr(num / 10)
        digits += 1
    end
    return digits
end


-- END OF general\math_lib.lua

-- START OF general\sfx_lib.lua
-- priority: -1

---Changes the volume of a given sfx through direct memmory access.
---@param number sfx
---@param number volume [0,7]
function change_sfx_volume(sfx,volume)
    sfx=flr(sfx)
    local v = flr(mid(0,volume,7))
    for i=0,31 do
        local n=0x3200+68*sfx+2*i
        poke2(n,%n&~0b111<<9|v<<9)
    end
end


-- END OF general\sfx_lib.lua

-- START OF general\table_lib.lua
-- priority: -1

---Creates non reactive copy of a table.
---@param table t
---@return table
function copy_table(t)
  local c = {}
  for k, v in pairs(t) do
    c[k] = v
  end
  return c
end

-- Source - https://stackoverflow.com/a/33511182
-- Posted by Oka, modified by community. See post 'Timeline' for change history
-- Retrieved 2026-01-28, License - CC BY-SA 3.0

function has_value (t, val)
    for i, v in ipairs(t) do
        if v == val then
            return true
        end
    end

    return false
end


-- END OF general\table_lib.lua

-- START OF general\text_lib.lua
-- priority: -1

---Prints text centered inside a given width.
---Automatically wraps words to multiple lines.
---@param msg string Text to print
---@param x number Left position in pixels
---@param y number Top position in pixels
---@param w number Width in pixels
function print_align_center(msg, x, y, w, col)
    local words = split(msg, " ")
    local rows = {}
    local current_row = ""

    for i=1, #words do
        local word = words[i]
        if current_row == "" then
            current_row = word
        else
            -- Check if adding the next word would exceed width
            if  str_width(current_row.." "..word)> w then
                add(rows, current_row)
                current_row = word
            else
                current_row ..= " " .. word
            end
        end
    end

    -- Add the last row if anything is left
    if current_row != "" then
        add(rows, current_row)
    end

    -- Print centered
    for i=1, #rows do
        local row = rows[i]
        print(row, x + (w - str_width(row)) / 2, y + 6 * (i-1), col)
    end
end

function str_width(str)
    local len = 0
    foreach(str, function (char)
        len += 4
        if (ord(char) >= 128) len+=4
    end)
    return len
end


-- END OF general\text_lib.lua

-- START OF general\time_lib.lua
-- priority: -1

---Returns number of frames for given seconds assuming 30 FPS.
---@param number seconds
---@param number frames
function seconds_to_frames(seconds)
    return flr(seconds*30)
end

---Returns number of seconds for given frames assuming 30 FPS.
---@param number frames
---@param number seconds
function frame_to_seconds(frames)
    return ceil(frames/30)    
end


-- END OF general\time_lib.lua

-- START OF general\vector_lib.lua
-- priority: -1

---Returns vector table between coordinate tables.
---@param a table {number x, number y}
---@param b table  {number x, number y}
---@return table {number x, number y}
function get_vector_from_points(a,b)
	return {x=b.x-a.x,y=b.y-a.y}
end

---Returns the magnitued of a given vector table.
---@param v table {number x, number y}
---@return number magnitude
function get_vector_length(v)
	return sqrt(v.x^2+v.y^2)
end

---Returns normilized vector table with magnitured of 1.
---@param v table {number x, number y}
---@return table {number x, number y}
function normalize_vector(v)
    if (get_vector_length(v) == 0) return log('Cannot normalize vector of lenght 0', "WARNING")
	v.x,v.y=v.x/get_vector_length(v),v.y/get_vector_length(v)
end

---Returns normilized vector table from an angle on a circle.
---@param number a [0,1) where 0 means right
---@return table {number x, number y}
function get_vector_from_angle(a)
	return {x=cos(a),y=sin(a)}
end

---Returns angle on a circle interval [0,1) where 0 means right from a given vector table.
---@param table {number x, number y}
---@returns number angle
function get_angle_from_vector(v)
	return atan2(v.x,v.y)
end


-- END OF general\vector_lib.lua

-- START OF particle_manager\particle.lua

-- priority: 1

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
-- END OF particle_manager\particle.lua

-- START OF scene_manager\scene.lua
-- priority : 1

Scene = {}
Scene.__index = Scene

function Scene:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl,self)
    
    return tbl   
end

function Scene:update()
    log("Scene has no update method", "WARNING")
end

function Scene:draw()
    log("Scene has no draw method", "WARNING")
end

function Scene:enter()
    log("Scene has no enter method", "WARNING")
end
-- END OF scene_manager\scene.lua

-- START OF camera\camera.lua
-- priority: 1

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
-- END OF camera\camera.lua

-- START OF particle_manager\particle_manager.lua
-- priority: 1

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
-- END OF particle_manager\particle_manager.lua

-- START OF scene_manager\scene_manager.lua
-- priority: 1

SceneManager = {
    current_scene=nil
}

function SceneManager:update()
    if (self.current_scene == nil) return log("No current scene", "Warning")

    self.current_scene:update()
end

function SceneManager:draw()
    if (self.current_scene == nil) return log("No current scene", "Warning")

    self.current_scene:draw()
end

function SceneManager:enter_scene(scene, tbl)
    tbl = tbl or {}
    self.current_scene = scene:new(tbl)
    self.current_scene:enter()
end
-- END OF scene_manager\scene_manager.lua

