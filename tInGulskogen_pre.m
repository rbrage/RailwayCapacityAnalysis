function [fire, transition] = tInGulskogen_pre(transition)

global global_info;

if not(mod(current_time(), global_info.freight_generation_delay) == 0),
    fire = 0;
        return;
end;

place = get_place('Gulskogen');

direction = 'N';
trainType = 'F';
stopPlace = 'Ganddal';
ctime = current_time();

token_bank = place.token_bank;

for i = token_bank,
    if ismember('F', i.color),
        fire = 0;
        return;
    end;
end;

transition.new_color = {direction trainType stopPlace};
transition.override = 1;
fire = 1;

fid = fopen('results/tGenFeigth.txt', 'a');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\n', string_HH_MM_SS(ctime), 'GENIN', direction, trainType, stopPlace);
fclose(fid);
