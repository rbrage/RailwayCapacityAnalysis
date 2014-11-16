function [fire, transition] = tInGulskogen_pre(transition)

global global_info;

place = get_place('Gulskogen');

direction = 'N';
trainType = 'F';
stopPlace = 'Ganddal';

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