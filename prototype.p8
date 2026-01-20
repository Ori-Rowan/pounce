pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

#include config.lua
#include src/utils.lua
#include src/logging.lua

function _init()
	player={
        x=64,
        y=64,
        spd=1,
    }
    rodent={
        x=flr(rnd(128)),
        y=flr(rnd(128)),
        timer=60,
        distance=0,
    }
    log('test')

end

function _update()
    player_movement(player)
    rodent_update()
    player_pounce()
end

function _draw()
    cls()

    -- draw player
    circ(player.x, player.y, 2, 7);

    -- debug
    --print(rodent.distance)

    --print(peek(0x3200))
end

-- player 

function player_movement(p)
	-- get dir angle from input
	local dirs,a={0.5,0,nil,0.25,0.375,0.125,0.25,0.75,0.625,0.875,0.75,nil,0.5,0},0
	for i=0,3 do
		a+=btn(i) and 2^i or 0
	end
	local p_dir=dirs[a]
	-- avoid cobble stoning
	if(p_dir!=p.dir) p.x,p.y=flr(p.x),flr(p.y)
	-- move if dir
	p.dir=p_dir
	if p_dir then
		entity_movement(p)
    end
end

function player_pounce()
    if btnp(4) then
        if rodent.distance <= 10 then
            catch()
        else
            sfx(1)
            pset(player.x, player.y, 7)  
        end
    end    
end

function catch()
    rodent.x=flr(rnd(128))
    rodent.y=flr(rnd(128))
    sfx(2)
end

function entity_movement(e)
	d=get_vector_from_angle(e.dir)
	e.x+=d.x*e.spd
	e.y+=d.y*e.spd
end

-- rodent
function rodent_update()
    -- get distance
    rodent.distance = get_vector_lenght(get_vector_from_points(rodent, player))

    -- check timer
    if rodent.timer>0 then
        rodent.timer-=1
    else
        
        volume = 7 - flr(rodent.distance / 15)
        log("Distance: "..rodent.distance)
        log("Squek vol: "..volume)
        change_sfx_volume(0, volume)
        sfx(0)
        rodent.timer=60
    end
end

function change_sfx_volume(sfx, volume)
    volume = mid(0, volume, 7)

    local sfx_addr = 0x3200 + 68*sfx

    for i=0,31 do
        local note_addr = sfx_addr + 2*i

        local low  = peek(note_addr)
        local high = peek(note_addr+1)

        -- rebuild 16-bit note
        local note = low | (high << 8)

        -- clear volume bits (9ヌ█⧗11)
        note = note & ~(0x7 << 9)

        -- set new volume (0ヌ█⧗7)

        note = note | (volume << 9)

        -- write back
        poke(note_addr,     note & 0xff)
        poke(note_addr + 1, (note >> 8) & 0xff)
    end
end


__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000355006550095500b5500f5501155014550175501e55022550275502e550335503d5503f5503155024550165501055006550015500b50004500025000250002500025000350003500045000050000500
00010000046501e6502b6502f6502e6502a6502765024650226501c6501865014650106500d6500b6500665003650016500065000000000000000000000000000000000000000000000000000000000000000000
001000000000027050310503000032000000002c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
