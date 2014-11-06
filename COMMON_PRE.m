function [fire, transition] = COMMON_PRE(transition)
% function [fire, trans] = COMMON_PRE(trans)
% disp(transition.name);
global global_info;
if ismember(transition.name, {'tInStavanger','tInSandnes','tInNaerbo','tInEgersund'}),
    fire = 1;
    return;
end;


%tokID = tokenAny(transition.name(6:end),1); % Take out any token in the station name in the transition
%colors = get_color(transition.name(6:end), tokID); % colors(routenr, 'N' or 'S')
%routnr = colors(1); % get the routnumber in colors
%train_type = char(colors(2));  % 'N' or 'S'

if eq(char(transition.name(1)),'S'),% South goning tranitions
  if strcmp(transition.name, 'SFSandnes'),
    % Take only out trains/tokens that is going to Egersund og Naerbo, and sends that token futhre
    tokID = tokenAnyColor(transition.name(3:end),1,{'Egersund', 'Naerbo'});
  elseif strcmp(transition.name, 'SFNaerbo'),
    % Take only out trains/tokens that is going to Egersund, and sends that token futhre
    tokID = tokenAnyColor(transition.name(3:end),1,{'Egersund'});
  else
    % Take only out trains/tokens that is going to South, and sends that token futhre
    tokID = tokenAnyColor(transition.name(3:end),1,{'South'});
  end;
elseif eq(transition.name(1),'N'), % South goning tranitions
  % Take only out trains/tokens that is going to North, and sends that token futhre
  tokID = tokenAnyColor(transition.name(3:end),1,{'North'});
end;
fire = tokID;
% if and(eq(char(transition.name(1)),'N'), fire ~= 0),
%         disp('#############################');
%         disp(transition.name);
%         disp(tokID)
%         disp(string_HH_MM_SS(current_time()));
% end;