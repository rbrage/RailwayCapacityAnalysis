function [fire, transition] = tInStavanger_pre(transition)

global global_info;

ctime = global_info.ctime+global_info.DELTA_TIME;

if not(isKey(global_info.timesToFireStavanger_Local, ctime)) && not(isKey(global_info.timeToFireStavanger_Regional, ctime)),
  fire = 0; return;
end;

if(isKey(global_info.timesToFireStavanger_Local, ctime)),
    direction = 'S';
    trainType = 'L';
    if global_info.times_rogaland_south(8,global_info.timesToFireStavanger_Local(ctime)) == -1,
      stopPlace = 'Sandnes';
    elseif global_info.times_rogaland_south(13,global_info.timesToFireStavanger_Local(ctime)) == -1,
      stopPlace = 'Naerbo';
    else
      stopPlace = 'Egersund';
    end;
    transition.new_color = {direction trainType stopPlace num2str(global_info.timesToFireStavanger_Local(ctime))};
    transition.override = 1;
    fire = 1;
    routenr = num2str(global_info.timesToFireStavanger_Local(ctime));

elseif (isKey(global_info.timeToFireStavanger_Regional, ctime)),
  direction = 'S';
  trainType = 'R';
  disp('Fire Regional from Stavanger');
  if global_info.times_regional_south(36, global_info.timeToFireStavanger_Regional(ctime)) == -1,
    stopPlace = 'Kristiansand';
    disp('Kristansand')
  else
    stopPlace = 'Drammen';
    disp('Drammen')
  end;
    transition.new_color = {direction trainType stopPlace num2str(global_info.timeToFireStavanger_Regional(ctime))};
    transition.override = 1;
    fire = 1;
    routenr = num2str(global_info.timeToFireStavanger_Regional(ctime));
else
  fire = 0;
end;

if fire == 1,
fid = fopen('results/tGenStavanger.txt', 'a');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\n', string_HH_MM_SS(ctime), 'GENIN', direction, trainType, routenr, stopPlace, string_HH_MM_SS(ctime));
fclose(fid);
end;
