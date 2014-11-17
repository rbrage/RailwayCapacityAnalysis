function [fire, transition] = tInMoi_pre(transition)

global global_info;

ctime = global_info.ctime+global_info.DELTA_TIME;

if not(isKey(global_info.timeToFireMoi,ctime)),
  fire = 0; return;
end;

if isKey(global_info.timeToFireMoi,ctime),
  if global_info.times_regional_south(global_info.stationnr('Moi')-1, global_info.timeToFireMoi(ctime)) == -1,
    direction = 'S';
    trainType = 'R';
    stopPlace = 'Kristiansand';
    routenr = num2str(global_info.timeToFireMoi(ctime));
    transition.new_color = {direction trainType stopPlace num2str(global_info.timeToFireMoi(ctime))};
    transition.override = 1;
    fire = 1;
  else
    fire = 0;
  end;
else
  fire = 0;
end;

if fire == 1,
  fid = fopen('results/tGenMoi.txt', 'a');
  fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\n', string_HH_MM_SS(ctime), 'GENIN', direction, trainType, stopPlace, string_HH_MM_SS(ctime), routenr);
  fclose(fid);
end;
