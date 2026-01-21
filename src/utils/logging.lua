
if _config.clear_on_start==true then
    printh("["..time().."][INFO]: logging start", _config.log_dir, true)
end

function log(msg, level)
    level = level or "INFO"
    log_text= "["..time().."]["..level.."]: "..msg
    printh(log_text, _config.log_dir)    
end
    