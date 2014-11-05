function [fire, transition] = tInEgersund_pre(transition)

global global_info;

if isempty(global_info.times_rogaland_north),

    fire = 0; return;

end;

ctime = current_time();
routenr = global_info.last_route_traveled_South;
maxroutes = size(global_info.times_rogaland_north(1,1:end));
if (maxroutes(2) == routenr)
    fire = 0;
    return;
end;
NTIT = 0;
while true,
    NTIT = convert_militery_time(global_info.times_rogaland_north(1, routenr + 1), 2);
    if and(NTIT == 0, routenr <= maxroutes(2)),
        routenr = routenr + 1;
    end;

    if (NTIT > 0), break; end;
    dist(routenr);
end

if eq(ctime, NTIT),
  trainType = global_info.next_train_type(1);
  global_info.last_route_traveled_South = routenr + 1;
  stopPlace = 'Stavanger';
  transition.new_color = {char(trainType), stopPlace};
  fire = 1;
else
  fire = 0;
end;
