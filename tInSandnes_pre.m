function [fire, transition] = tInSandnes_pre(transition)

global global_info;

if isempty(global_info.times_rogaland_north),
    fire = 0; return;
end;

ctime = current_time();
routenr = global_info.last_route_traveled_North;
maxroutes = size(global_info.times_rogaland_north(13,1:end));
if (maxroutes(2) <= routenr)
    fire = 0;
    return;
end;

NTIT = convert_militery_time(global_info.times_rogaland_north(13, routenr + 1), 2);
PreviousStation = global_info.times_rogaland_north(12, routenr + 1);

if PreviousStation ~= 0,
    fire = 0;
    return;
end;

if NTIT == 0,
    fire = 0;
    return;
end;

if ctime >= NTIT-global_info.DELTA_TIME,
  trainType = global_info.next_train_type(1);
  global_info.last_route_traveled_North = routenr + 1;
  stopPlace = 'Stavanger';
  transition.new_color = [trainType stopPlace num2str(routenr+1)];
  fire = 1;
else
   
  fire = 0;
end;


