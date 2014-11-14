function [fire, transition] = tInStavanger_pre(transition)

global global_info;

ctime = current_time();
localroutenr = global_info.last_route_traveled_South;


if isempty(global_info.times_rogaland_south) && not(isKey(global_info.timeToFireStavanger_Regional, ctime)),
  fire = 0; return;
end;

if (isKey(global_info.timeToFireStavanger_Regional, ctime)),
  direction = 'N';
  trainType = 'R';
  global_info.last_Regional_route_traveled_South = regionalroutenr + 1;
  %if()
  stopPlace = 'Stavanger';
  transition.new_color = {direction trainType stopPlace num2str(global_info.timeToFireEgersund(ctime))};
  transition.override = 1;
  fire = 1;

else,
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

  if eq(ctime, NTIT-global_info.DELTA_TIME),
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
  else
    fire = 0;
  end;

end;
