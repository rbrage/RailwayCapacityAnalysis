% converts militery time to number of seconds
% There is to types that can be used:
% Type 1: 00000 - 235959
% Type 2: 0000 - 2359
function [sec] = convert_militery_time(mil, type)

if (type == 1)
    if (mil > 235959 || mil < 0)
        sec = -1;
        return; 
    end;
    
    hour = floor(mil/10000);
    min = floor((mil-(hour*10000))/100);
    sec = mil - (hour*10000 + min*100);
    sec = hour*60*60 + min*60 + sec;
    return;
elseif(type == 2)
    if (mil > 2359 || mil < 0)
        sec = -1;
        return; 
    end;
    
    hour = floor(mil/100);
    min = (mil-(hour*100));
    sec = hour*60*60 + min*60;
    return;
else
    sec = -1;
    return
end



