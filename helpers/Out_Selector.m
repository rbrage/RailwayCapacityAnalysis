function [fire, transition] = Out_Selector(transition)

station = transition.name(5:end);
tokID = tokenAnyColor(station,1,station);

if not(tokID),
    fire = 0;
else
    transition.selected_tokens = tokID;
    fire=1;
end;
