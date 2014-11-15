function [fire, transition] = tInDrammen_pre(transition)

global global_info;

ctime = current_time()+global_info.DELTA_TIME;

if not(isKey(global_info.timeToFireDrammen,ctime)),
  fire = 0; return;
end;

if isKey(global_info.timeToFireDrammen,ctime),
  if global_info.times_regional_north(global_info.stationnr('Kristiansand')+4, global_info.timeToFireDrammen(ctime)) == -1,
    direction = 'N';
    trainType = 'R';
    stopPlace = 'Kristiansand';
    routenr = num2str(global_info.timeToFireDrammen(ctime));
    transition.new_color = {direction trainType stopPlace num2str(global_info.timeToFireDrammen(ctime))};
    transition.override = 1;
    fire = 1;
  else
    direction = 'N';
    trainType = 'R';
    stopPlace = 'Stavanger';
    routenr = num2str(global_info.timeToFireDrammen(ctime));
    transition.new_color = {direction trainType stopPlace num2str(global_info.timeToFireDrammen(ctime))};
    transition.override = 1;
    fire = 1;
  end;
else
    fire = 0;
end;

if fire == 1,
  fid = fopen('results/tGenDrammen.txt', 'a');
  fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\n', string_HH_MM_SS(ctime), 'GENIN', direction, trainType, stopPlace, string_HH_MM_SS(ctime), routenr);
  fclose(fid);
end;
