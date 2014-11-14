function [fire, transition] = tInEgersund_pre(transition)
global global_info;

if isempty(global_info.times_rogaland_north),
    disp('global_info.times_rogaland_north isempty, fire = 0')
    fire = 0; return;

end;

ctime = current_time()+global_info.DELTA_TIME;
% routenr = global_info.last_route_traveled_North;
% maxroutes = size(global_info.times_rogaland_north(1,1:end));
%
% if (maxroutes(2) == routenr),
%   disp('Fire = 0, return');
%     fire = 0;
%     return;
% end;
%isKey(global_info.timeToFireEgersund,current_clock(1))
if not(isKey(global_info.timeToFireEgersund,ctime)),
  % disp('------------------------')
  % string_HH_MM_SS(current_time())
  % disp('Is in map Egersund');
  % global_info.timeToFireEgersund(ctime)
    fire = 0;
    return;
end;

direction = 'N';
trainType = 'L';
%global_info.last_route_traveled_North = routenr + 1;
stopPlace = 'Stavanger';
transition.new_color = {direction trainType stopPlace num2str(global_info.timeToFireEgersund(ctime))};
transition.override = 1;
fire = 1;
