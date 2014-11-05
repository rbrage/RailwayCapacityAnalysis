function [fire, transition] = COMMON_PRE(transition)
% function [fire, trans] = COMMON_PRE(trans)
% disp(transition.name);

if ismember(transition.name, {'tInStavanger','tInSandnes'}),
    fire = 1;
    return;
end;

train_type = transition.name(1);  % 'N' or 'S'
if (eq(train_type, double('S'))),
  fire = 1;
else
  fire = 0;
end;
%   tokID = tokenAny(transition.name,1);
%   colors = get_color(transition.name, tokID);
% disp(colors);
  %tokID, colors);
%granted = request(transition.name, {'Resource-X',1});
%fire = granted; % fire only if resource acquire is sucessful
