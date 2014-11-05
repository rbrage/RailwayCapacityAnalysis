function [fire, transition] = COMMON_PRE(transition)
% function [fire, trans] = COMMON_PRE(trans)
% disp(transition.name);
global global_info;
if ismember(transition.name, {'tInStavanger','tInSandnes'}),
    fire = 1;
    return;
end;


%tokID = tokenAnyColor(transition.name(6:end),1); % Take out the station name in the transition
%colors = get_color(transition.name(6:end), tokID); % colors(routenr, 'N' or 'S')
%routnr = colors(1); % get the routnumber in colors
train_type = transition.name(1);  % 'N' or 'S'


if (eq(train_type, double('S'))),
  if strcmp(transition.name, 'SFromSandnes'),
    tokID = tokenAnyColor(transition.name(6:end),1,{'Egersund', 'Naerbo'});
  elseif strcmp(transition.name, 'SFromNaerbo'),
    tokID = tokenAnyColor(transition.name(6:end),1,{'Egersund'});
  else
    tokID = 1;
  end;
end;

fire = tokID;

%   tokID = tokenAny(transition.name,1);
%   colors = get_color(transition.name, tokID);
% disp(colors);
  %tokID, colors);
%granted = request(transition.name, {'Resource-X',1});
%fire = granted; % fire only if resource acquire is sucessful
