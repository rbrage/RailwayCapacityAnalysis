function [fire, transition] = COMMON_PRE(transition)

global global_info;
% Check if there is an other prefile to be runned instead.
if ismember(transition.name, {'tInStavanger','tInSandnes','tInNaerbo','tInEgersund', 'tOutStavangerS','tOutSandnes','tOutNaerbo','tOutEgersund'}),
    fire = 1;
    return;
end;



direction = char(transition.name(1));
ctime = mod(current_time(), 24*60*60);
station = transition.name(3:end);

if eq(direction, 'N'),
    from_station = char(global_info.stations(global_info.stationnr(station) + 1));
    to_station = char(station);
else
    from_station = char(station);
    to_station = char(global_info.stations(global_info.stationnr(station) + 1));
end;

if strcmpi(direction, {'S'}),
    if strcmpi(transition.name, {'SFSandnes'}),
        tokID = tokenAnyColor(from_station,1,{'Egersund', 'Naerbo'});
    elseif strcmpi(transition.name, {'SFNaerbo'}),
        tokID = tokenAnyColor(from_station,1,{'Egersund'});
    else
        tokID = tokenAnyColor(from_station,1,{'S'});
    end;
else
    tokID = tokenAnyColor(from_station,1,{'N'});
end;


% if no token is found return
if (not(tokID)),
    fire = 0;
    return;
end;

% try to get ownership of the track.
if (global_info.tracks_south(station) == 1),
    granted = request(transition.name, {station,1});
else
    granted = request(transition.name, {transition.name,1});
end;



time=0;
colors = get_color(from_station, tokID); % colors(routenr, 'N' or 'S')
routnr = str2num(colors{1}); % get the routnumber in colors

if eq(direction, 'S'),
    time = global_info.times_rogaland_south(global_info.stationnr(from_station),routnr);
else
    time = global_info.times_rogaland_north(length(global_info.stations) + 1 - global_info.stationnr(from_station), routnr);
    
    fid = fopen('results/run_timesN.txt', 'a');
    fprintf(fid, '%d\t %d\t%d\t %d\t %s\t \n', time, global_info.times_rogaland_north(length(global_info.stations)+1-global_info.stationnr(from_station), routnr),length(global_info.stations)+1-global_info.stationnr(from_station), routnr, from_station);
    fclose(fid);
end;

if time < 0,
    fire = 0;
    return;
end;

% checks if the resource is granted
if granted,
    %disp([ctime convert_militery_time(time, 2) [ctime >= convert_militery_time(time, 2)]]);
    if ctime >= convert_militery_time(time, 2),
        transition.selected_tokens = tokID;
        fire = 1;
    elseif abs(ctime - convert_militery_time(time, 2)) >= 12*60*60,
        transition.selected_tokens = tokID;
        fire = 1;
    else
        fire=0;
    end;
else
    fid = fopen('results/run_collisions.txt', 'a');
    fprintf(fid, '%s\t %s\t %s\t %s\t %s\t %d\t %s\n', string_HH_MM_SS(ctime), direction, from_station, to_station, string_HH_MM_SS(convert_militery_time(time, 2)),routnr, transition.name);
    fclose(fid);
    fire = 0;
    return;
end;

% Writes action to result file

fid = fopen('results/run.txt', 'a');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t|%d\n', string_HH_MM_SS(ctime), 'D', direction, station, string_HH_MM_SS(convert_militery_time(time, 2)),routnr);
fclose(fid);
if fire == 1,
  if eq(direction,'S'),
    fid = fopen('results/run_south.txt', 'a');
    fprintf(fid, '%s\t%s\t%s\t%s\t%s\t|%d\t|%d\n', string_HH_MM_SS(ctime), 'D', direction, station, string_HH_MM_SS(convert_militery_time(time, 2)),routnr,granted);
    fclose(fid);
  else
    fid = fopen('results/run_north.txt', 'a');
    fprintf(fid, '%s\t%s\t%s\t%s\t%s\t|%d\t|%d\n', string_HH_MM_SS(ctime), 'D', direction, from_station, string_HH_MM_SS(convert_militery_time(time, 2)),routnr,granted);
    fclose(fid);
  end;
end;

% if and(eq(char(transition.name(1)),'N'), fire ~= 0),
%         disp('#############################');
%         disp(transition.name);
%         disp(tokID)
%         disp(string_HH_MM_SS(current_time()));
% end;
