% Example-34-1: Project Completion Time
function [fire, transition] = COMMON_PRE(transition)
fire = request(transition.name);  % request any one instance of resource
