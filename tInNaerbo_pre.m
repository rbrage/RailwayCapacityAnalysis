function [fire, transition] = tInNaerbo_pre(transition)

global global_info;

if isempty(global_info.times_rogaland_north),
    fire = 0; return;
end;

ctime = current_time();
% routenr = global_info.last_route_traveled_North;
% maxroutes = size(global_info.times_rogaland_north(8,1:end));
% if (maxroutes(2) == routenr)
%     fire = 0;
%     return;
% end;
if isKey(global_info.timeToFireNaerbo,ctime),
  % disp('------------------------')
  % string_HH_MM_SS(current_time())
  % disp('Is in map Naerbo');
  % global_info.timeToFireNaerbo(ctime)
  NTIT = convert_militery_time(global_info.times_rogaland_north(8, global_info.timeToFireNaerbo(ctime)), 2);
  PreviousStation = global_info.times_rogaland_north(7, global_info.timeToFireNaerbo(ctime));
else
  NTIT = 0;
  PreviousStation = 0;
end;

%NTIT = convert_militery_time(global_info.times_rogaland_north(8, routenr + 1), 2);
%PreviousStation = global_info.times_rogaland_north(7, routenr + 1);

if PreviousStation ~= 0,
    fire = 0;
    return;
end;

if NTIT == 0,
    fire = 0;
    return;
end;

if ctime >= NTIT-global_info.DELTA_TIME,
  direction = 'N';
  trainType = 'L';
%  global_info.last_route_traveled_North = routenr + 1;
  stopPlace = 'Stavanger';
  transition.new_color = {direction trainType stopPlace num2str(global_info.timeToFireNaerbo(ctime))};
  %disp(transition.new_color);
  fire = 1;
else
  fire = 0;
end;
