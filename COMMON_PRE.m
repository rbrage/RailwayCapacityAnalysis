function [fire, transition] = COMMON_PRE(transition)

global global_info;
%% Check if there is an other prefile to be runned instead.
if ismember(transition.name, {'tInStavanger','tInSandnes','tInNaerbo',...
        'tInEgersund', 'tInMoi' 'tInKristiansand', 'tInDrammen', 'tInGanddal', 'tInGulskogen'}),
    fire = 1;
    return;
end;

if ismember(transition.name, {'tOutStavangerS','tOutSandnes','tOutNaerbo','tOutEgersund','tOutKristiansand','tOutDrammen', 'tOutGulskogen', 'tOutGanddal'}),
    [fire, transition] = Out_Selector(transition);
    return;
end;

%% Finds transition information
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

%% try to get ownership of the track.
if (global_info.tracks_south(station) == 1),
    granted = request(transition.name, {station,1});
else
    granted = request(transition.name, {transition.name,1});
end;

% will only fire if it didn't get ownership of the tracks.
if not(granted),
    fire = 0;
    return;
end;

%% Selects a token to travel on the track.
[tokens, valid] = tokenAnyColor(from_station, 100, {direction});

if valid == 0,
    fire = 0;
    release(transition.name);
    return;
end;

tokID = 0;
hasRegional = 0;
train_type = 'X';
for i = 1:valid,
    c = get_color(from_station, tokens(i));
    % is it at the end station
    if ismember(from_station, c),
        continue;
    end;

    % Looks for a local train. Local trains have the highets priority and
    % this gets picked. By breaking the loop the first local train arraived
    % will be picked.
    if ismember('L', c),
        tokID = tokens(i);
        train_type = 'L';
        break;
    end;

    % Looks for a regional train. This will owerwrite a freigth train if it
    % has already found one.
    if ismember('R', c),
        tokID = tokens(i);
        hasRegional = 1;
        train_type = 'R';
        continue;
    end;

    % Looks for a freight train only if it hasn't found any other type yet.
    if ismember('F', c) && not(hasRegional),
        tokID = tokens(i);
        train_type = 'F';
    end;
end;


% if no token is found return
if not(tokID),
    fire = 0;
    release(transition.name);
    return;
end;

%% Sends a freight train to next station.
if strcmp(train_type, 'F'),
    ftime = get_firingtime(transition.name);
    
    arvtime = ctime + ftime;
    
%     if strcmp(direction, 'S'),
        if global_info.stationnr(from_station) < global_info.stationnr('Egersund'),
            tmpt = global_info.times_rogaland_south(global_info.stationnr(from_station),1:end);
            tmp2 = tmpt >= floor((floor(ctime/60/60)*100) + (mod((ctime/60),60))) & tmpt <= floor((floor(arvtime/60/60)*100) + (mod((arvtime/60),60)));
            if ismember(1, tmp2),
                disp('Freight train holdback');
                fire = 0;
                release(transition.name);
                return;
            end;
        end;
        
        row = (global_info.stationnr(from_station));
        tmpt = global_info.times_regional_south(row, 1:end);
        tmp2 = tmpt >= floor((floor(ctime/60/60)*100) + (mod((ctime/60),60))) & tmpt <= floor((floor(arvtime/60/60)*100) + (mod((arvtime/60),60)));
        if ismember(1, tmp2),
            disp('Freight train holdback');
            fire = 0;
            release(transition.name);
            return;
        end;
%     else
        if global_info.stationnr(from_station) < global_info.stationnr('Egersund'),
            tmpt = global_info.times_rogaland_north(size(global_info.times_rogaland_north,1) + 1 - global_info.stationnr(from_station), 1:end);
            tmp2 = tmpt >= floor((floor(ctime/60/60)*100) + (mod((ctime/60),60))) & tmpt <= floor((floor(arvtime/60/60)*100) + (mod((arvtime/60),60)));
            if ismember(1, tmp2),
                disp('Freight train holdback');
                fire = 0;
                release(transition.name);
                return;
            end;
        end;
%         end;
        
        row = size(global_info.times_regional_north,1) - global_info.stationnr(from_station) + 1;
        tmpt = global_info.times_regional_north(row, 1:end);
        tmp2 = tmpt >= floor((floor(ctime/60/60)*100) + (mod((ctime/60),60))) & tmpt <= floor((floor(arvtime/60/60)*100) + (mod((arvtime/60),60)));
        if ismember(1, tmp2),
            disp('Freight train holdback');
            fire = 0;
            release(transition.name);
            return;
        end;
    
    disp('Freight train sendt to next station.');
    fire = tokID;
    return;
end;

%% Gets the time for the train to leave.
colors = get_color(from_station, tokID); % colors(routenr, 'N' or 'S')
routnr = str2num(colors{1}); % get the routnumber in colors

if eq(direction, 'S'),
    if eq(train_type, 'L'),
        time = global_info.times_rogaland_south(global_info.stationnr(from_station),routnr);
    elseif eq(train_type, 'R'),
      row = (global_info.stationnr(from_station));
      time = global_info.times_regional_south(row, routnr);
      if time == -2,
        time = floor((floor(ctime/60/60)*100) + (mod((ctime/60),60)));
      end;
      else
        error('Unknown train type.');
    end;
else
    if eq(train_type, 'L'),
      time = global_info.times_rogaland_north(size(global_info.times_rogaland_north,1) + 1 - global_info.stationnr(from_station), routnr);
    elseif eq(train_type, 'R'),
      row = size(global_info.times_regional_north,1) - global_info.stationnr(from_station) + 1;
      time = global_info.times_regional_north(row, routnr);
      if time == -2,
        time = floor((floor(ctime/60/60)*100) + (mod((ctime/60),60)));
      end;
    else
        error('Unknown train type.');
    end;
end;

if (strcmpi(num2str(routnr), '5') && strcmpi(train_type, 'R') && strcmpi(direction, 'N')),
 disp(['From station: ',from_station,' Routnr: ', num2str(routnr), ' Row: ',num2str(row), ' Time: ', num2str(time), ' ctime: ',string_HH_MM_SS(ctime)]);
end;

%% processing the time
time = convert_militery_time(time, 2);
if abs(time - ctime) >= 20*60*60,
    time = time + 24*60*60;
end;

% if no time, then dont fire.
if time < 0,
    fire = 0;
    release(transition.name);
    return;
end;

%% Checks if its time to leave acording to the timetable.
if ctime >= time,
    transition.selected_tokens = tokID;
    fire = tokID;
else
    fire = 0;
    release(transition.name);
    return;
end;

%% Logs information if the train is leaving after what was set in the
% timetable.
if ctime > time,
    fid = fopen('results/delays.txt', 'a');
    fprintf(fid, '%s\t%s\t%s\t%s\t%d\t%s\t%s\t%s\n', string_HH_MM_SS(ctime), string_HH_MM_SS(time), direction, train_type, routnr, from_station, to_station, transition.name);
    fclose(fid);
end;

%% Writes action to result file
fid = fopen('results/run.txt', 'a');
fprintf(fid, '%s\t%s\t%s\t%s\t%d\t%s\t%s\n', string_HH_MM_SS(ctime), 'D', direction, train_type, routnr, string_HH_MM_SS(time), station);
fclose(fid);
  if eq(direction,'S'),
    fid = fopen('results/run_south.txt', 'a');
    fprintf(fid, '%s\t%s\t%s\t%s\t%d\t%s\t%s\n', string_HH_MM_SS(ctime), 'D', direction, train_type, routnr, string_HH_MM_SS(time), station);
    fclose(fid);
  else
    fid = fopen('results/run_north.txt', 'a');
    fprintf(fid, '%s\t%s\t%s\t%s\t%d\t%s\t%s\n', string_HH_MM_SS(ctime), 'D', direction, train_type, routnr, string_HH_MM_SS(time), from_station);
    fclose(fid);
end;
