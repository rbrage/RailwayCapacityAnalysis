function [fire, transition] = tOutSandnes_pre(transition)

global global_info;


ctime = current_time();
station = transition.name(5:11);
tokID = tokenAnyColor(station,1,{'Sandnes'});

if not(tokID),
  fire = 0;
else
  colors = get_color(station, tokID);
%  disp(['Time: ', string_HH_MM_SS(ctime) ,'. Station: ',station,' TokID: ', num2str(tokID)]);
%  colors
  fire=1;
end;
