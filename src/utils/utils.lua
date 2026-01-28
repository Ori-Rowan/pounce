
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

function change_sfx_volume(sfx,volume)
    local v = mid(0,volume,7)
    for i=0,31 do
        local n=0x3200+68*sfx+2*i
        poke2(n,%n&~0b111<<9|v<<9)
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

-- print
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

-- table
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

local function has_value (t, val)
    for i, v in ipairs(t) do
        if v == val then
            return true
        end
    end

    return false
end

 