Score = {}
Score.__index = Score

function Score:new(tbl)
    tbl = tbl or {}

    setmetatable(tbl, self)

    tbl.value=0
    tbl.max_digits = tbl.max_digits or 4

    return tbl
end

function Score:update()
    return
end

function Score:draw()
    print(self:get_score_string(), 6, 16, 0)
end

function Score:add_score(score)
    self.value += score;
end

function Score:get_score_string()
    local str = tostr(self.value)
    local score_digits = get_digits(self.value)

    for i=1, self.max_digits-score_digits do
        str = "0"..str
    end

    return str
end
