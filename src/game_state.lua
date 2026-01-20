GameState = {}
GameState.__index=GameState


function GameState:new(tbl)
    tbl = tbl or {}
    
    setmetatable(tbl, self)

    assert(tbl.timer)

    tbl:set_timer(tbl.timer)
    tbl.score = 0

    return tbl;
end

function GameState:update()
    self.timer -= 1
end

function GameState:set_timer(seconds)
    self.timer = seconds_to_frames(seconds)
end

function GameState:draw()
    print(frame_to_seconds(self.timer))
    print(self:get_score_string())
end

function GameState:add_score(score)
    self.score += score;
end

function GameState:get_score_string()
    local str = tostr(self.score)
    local score_digits = get_digits(self.score)

    for i=0, 3-score_digits do
        str = "0"..str
    end

    return str
end
