function [fire, transition] = tInGulskogen_pre(transition)

global global_info;

direction = 'N';
trainType = 'F';
stopPlace = 'Gulskogen';
ctime = current_time();


mtime = floor((floor(ctime/60/60)*100) + (mod((ctime/60),60)));

if ismember(num2str(mtime), global_info.freight_generation_gulskogen),
    pos = find(strcmp(global_info.freight_generation_gulskogen, num2str(mtime)));
    if size(pos) ~= 1,
        error('There is an error in the times generating the freight trains');
    end;
    
    stopPlace = strjoin(global_info.freight_generation_gulskogen(pos + 1), '');
else
    fire = 0;
    return;
end;

transition.new_color = {direction trainType stopPlace};
transition.override = 1;
fire = 1;

fid = fopen('results/tGenFeigth.txt', 'a');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\n', string_HH_MM_SS(ctime), 'GENIN', direction, trainType, stopPlace);
fclose(fid);