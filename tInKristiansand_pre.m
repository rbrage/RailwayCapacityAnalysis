function [fire, transition] = tInKristiansand_pre(transition)

global global_info;

ctime = current_time()+global_info.DELTA_TIME;

if not(isKey(global_info.timeToFireKristiandsand_South,ctime)) && not(isKey(global_info.timeToFireKristiandsand_North, ctime)),
  fire = 0; return;
end;

if isKey(global_info.timeToFireKristiandsand_South,ctime),
  if global_info.times_regional_south(global_info.stationnr('Kristiansand')-1, global_info.timeToFireKristiandsand_South(ctime)) == -1,
    direction = 'S';
    trainType = 'R';
    stopPlace = 'Drammen';
    routenr = num2str(global_info.timeToFireKristiandsand_South(ctime));
    transition.new_color = {direction trainType stopPlace num2str(global_info.timeToFireKristiandsand_South(ctime))};
    transition.override = 1;
    fire = 1;
    fid = fopen('results/tGenKristiansand.txt', 'a');
    fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\n', string_HH_MM_SS(ctime), 'GENIN', direction, trainType, stopPlace, string_HH_MM_SS(ctime), routenr);
    fclose(fid);
  else
    fire = 0;
  end;

elseif isKey(global_info.timeToFireKristiandsand_North,ctime),
  if global_info.times_regional_north(global_info.stationnr('Kristiansand')+2, global_info.timeToFireKristiandsand_North(ctime)) == -1,
    direction = 'N';
    trainType = 'R';
    stopPlace = 'Stavanger';
    routenr = num2str(global_info.timeToFireKristiandsand_North(ctime));
    transition.new_color = {direction trainType stopPlace num2str(global_info.timeToFireKristiandsand_North(ctime))};
    transition.override = 1;
    fire = 1;
    fid = fopen('results/tGenKristiansand.txt', 'a');
    fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\n', string_HH_MM_SS(ctime), 'GENIN', direction, trainType, stopPlace, string_HH_MM_SS(ctime), routenr);
    fclose(fid);
  else
      fire = 0;
  end;

else
  fire = 0;
end;
