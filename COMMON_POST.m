function [] = COMMON_POST(transition)

global global_info;
% release all resources used by transition
release(transition.name);
