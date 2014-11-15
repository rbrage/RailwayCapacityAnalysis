function [fire, transition] = tInSandnes_pre(transition)

global global_info;

if isempty(global_info.times_rogaland_north),
    fire = 0; return;
end;

ctime = current_time()+global_info.DELTA_TIME;
% routenr = global_info.last_route_traveled_North;
% maxroutes = size(global_info.times_rogaland_north(13,1:end));
% if (maxroutes(2) <= routenr)
%     fire = 0;
%     return;
% end;
if isKey(global_info.timeToFireSandnes,ctime),
  %  disp('------------------------')
  %  string_HH_MM_SS(current_time())
  %  disp('Is in map Sandnes');
  %  global_info.timeToFireSandnes(ctime)
  NTIT = convert_militery_time(global_info.times_rogaland_north(13, global_info.timeToFireSandnes(ctime)), 2);
  if global_info.times_rogaland_north(12, global_info.timeToFireSandnes(ctime)) ~= -1,
      fire = 0;
      return;
  end;
else
  fire = 0;
    return;
end;

direction = 'N';
trainType = 'L';
%global_info.last_route_traveled_North = routenr + 1;
stopPlace = 'StavangerS';
routenr = num2str(global_info.timeToFireSandnes(ctime));
transition.new_color = {direction trainType stopPlace routenr};
transition.override = 1;
fire = 1;

fid = fopen('results/tGenSandnes.txt', 'a');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t|%s\n', string_HH_MM_SS(ctime), 'GENIN', direction, '', string_HH_MM_SS(NTIT), routenr);
fclose(fid);
