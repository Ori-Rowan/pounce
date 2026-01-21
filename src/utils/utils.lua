
-- vector library

function get_vector_from_points(a,b)
	return {x=b.x-a.x,y=b.y-a.y}
end

function get_vector_length(v)
	return sqrt(v.x^2+v.y^2)
end

function normalize_vector(v)
    if (get_vector_length(v) == 0) return log('Cannot normalize vector of lenght 0', "WARNING")
	v.x,v.y=v.x/get_vector_length(v),v.y/get_vector_length(v)
end

function get_vector_from_angle(a)
	return {x=cos(a),y=sin(a)}
end

function get_angle_from_vector(v)
	return atan2(v.x,v.y)
end

-- sfx
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

-- 8d input

function get_8d_input()
	-- get dir angle from input
	local dirs,a={0.5,0,nil,0.25,0.375,0.125,0.25,0.75,0.625,0.875,0.75,nil,0.5,0},0
	for i=0,3 do
		a+=btn(i) and 2^i or 0
	end
	return dirs[a]
end


-- entity behaviour

-- dir angle + spd
function entity_movement(e)
	local d=get_vector_from_angle(e.dir)
	e.x+=d.x*e.spd
	e.y+=d.y*e.spd
end

-- time
function seconds_to_frames(s)
    return flr(s*30)
end

function frame_to_seconds(f)
    return ceil(f/30)    
end

-- math
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
