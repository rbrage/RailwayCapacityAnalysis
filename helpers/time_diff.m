% Finds the difference between values in a array
% Values in array have to be in military integer time, of the form
% 0000-2359.
function [diff] = time_diff(times)

len = length(times);
diff = zeros(1,len-1);
for i = 1:len-1,
   diff(i) = convert_militery_time(times(i + 1), 2) - convert_militery_time(times(i), 2);
end;
    
    