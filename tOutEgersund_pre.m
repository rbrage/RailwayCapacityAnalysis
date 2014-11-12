function [fire, transition] = tOutEgersund_pre(transition)

global global_info;


ctime = current_time();
station = transition.name(5:12);
tokID = tokenAnyColor(station,1,{'Egersund'});

if not(tokID),
  fire = 0;
else
  colors = get_color(station, tokID);
%  disp(['Time: ', string_HH_MM_SS(ctime) ,'. Station: ',station,' TokID: ', char(tokID)]);
%  colors
  fire=1;
end;
