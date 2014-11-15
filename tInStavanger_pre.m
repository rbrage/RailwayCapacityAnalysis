function [fire, transition] = tInStavanger_pre(transition)

global global_info;

ctime = current_time()+global_info.DELTA_TIME;
localroutenr = global_info.last_route_traveled_South;

if isempty(global_info.times_rogaland_south) && not(isKey(global_info.timeToFireStavanger_Regional, ctime)),
  fire = 0; return;
end;

if (isKey(global_info.timeToFireStavanger_Regional, ctime)),
  direction = 'S';
  trainType = 'R';

  if global_info.times_regional_south(36, global_info.timeToFireStavanger_Regional(ctime)) == -1,
    stopPlace = 'Kristiansand';
  else
    stopPlace = 'Drammen';
  end;
    transition.new_color = {direction trainType stopPlace num2str(global_info.timeToFireStavanger_Regional(ctime))};
    transition.override = 1;
    fire = 1;
    routenr = num2str(global_info.timeToFireStavanger_Regional(ctime));
    NTIT = ctime;
else
  ctime = current_time();
  maxroutes = size(global_info.times_rogaland_south(1,1:end));
  if (maxroutes(2) == localroutenr)
      fire = 0;
      return;
  end;
  NTIT = 0;
  while true,
      NTIT = convert_militery_time(global_info.times_rogaland_south(1, localroutenr + 1), 2);
      if and(NTIT < 0, localroutenr <= maxroutes(2)),
          localroutenr = localroutenr + 1;
      end;

      if (NTIT > -1), break; end;
  end;

  NTIT = NTIT-global_info.DELTA_TIME;
  if eq(ctime, NTIT),
    direction = 'S';
    trainType = 'L';
    global_info.last_route_traveled_South = localroutenr + 1;
    if(global_info.times_rogaland_south(8,localroutenr+1) == -1),
      stopPlace = 'Sandnes';
    elseif (global_info.times_rogaland_south(13,localroutenr+1) == -1),
      stopPlace = 'Naerbo';
    else
      stopPlace = 'Egersund';
    end;
    transition.new_color = {direction trainType stopPlace num2str(localroutenr+1)};
    transition.override = 1;
    fire = 1;
    routenr = num2str(localroutenr+1);
  else
    fire = 0;
  end;

end;

if fire == 1,
fid = fopen('results/tGenStavanger.txt', 'a');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\n', string_HH_MM_SS(ctime), 'GENIN', direction, trainType, stopPlace, string_HH_MM_SS(NTIT), routenr);
fclose(fid);
end;
