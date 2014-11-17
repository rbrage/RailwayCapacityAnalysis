function [fire, transition] = tInEgersund_pre(transition)
global global_info;

if isempty(global_info.times_rogaland_north),
    disp('global_info.times_rogaland_north isempty, fire = 0')
    fire = 0; return;

end;

ctime = global_info.ctime+global_info.DELTA_TIME;
if not(isKey(global_info.timeToFireEgersund,ctime)),
    fire = 0;
    return;
end;

direction = 'N';
trainType = 'L';
stopPlace = 'StavangerS';
transition.new_color = {direction trainType stopPlace num2str(global_info.timeToFireEgersund(ctime))};
transition.override = 1;
fire = 1;
