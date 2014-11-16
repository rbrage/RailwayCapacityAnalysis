function [fire, transition] = tInGanddal_pre(transition)

global global_info;

place = get_place('Ganddal');

direction = 'N';
trainType = 'F';
stopPlace = 'Gulskogen';

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