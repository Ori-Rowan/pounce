
if clear_on_start==true then
    printh("["..time().."][INFO]: logging start", log_dir, true)
end

function log(msg, level)
    level = level or "INFO"
    log_text= "["..time().."]["..level.."]: "..msg
    printh(log_text, log_dir)    
end