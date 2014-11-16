function [fire, transition] = tInGanddal_pre(transition)

global global_info;

if not(mod(current_time(), global_info.freight_generation_delay) == 0),
    fire = 0;
        return;
end;

place = get_place('Ganddal');
before = get_place('Sandnes');
front = get_place('Oksnavadporten');

direction = 'S';
trainType = 'F';
stopPlace = 'Gulskogen';
ctime = current_time();

token_bank = place.token_bank;
token_bank_before = before.token_bank;
token_bank_front = front.token_bank;

for i = token_bank,
    if ismember('F', i.color),
        fire = 0;
        return;
    end;
end;
for i = token_bank_before,
  disp(ismember({'R','L'}, i.color));
    if ismember({'R','L'}, i.color),
      disp(['Station before: ', before, 'has colors: ', i.color]);
        fire = 0;
        return;
    end;
end;
for i = token_bank_front,
  disp(ismember({'R','L'}, i.color));
    if ismember({'R','L'}, i.color),
        disp(['Station front: ', front, 'has colors: ', i.color]);
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
