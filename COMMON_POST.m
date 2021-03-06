function [] = COMMON_POST(transition)

global global_info;

%% release all resources used by transition
release(transition.name);

%% filters non processable transitions
if ismember(transition.name, {'tInStavanger','tInSandnes','tInNaerbo',...
        'tInEgersund', 'tInMoi', 'tInKristiansand', 'tInDrammen','tOutStavangerS',...
        'tOutSandnes','tOutNaerbo','tOutEgersund','tOutKristiansand','tOutDrammen', 'tInGanddal', 'tInGulskogen', 'tOutGulskogen', 'tOutGanddal', 'tOutNeslandsvatn'}),
    return;
end;

%% gets transition info
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

%% Checks for over capasity on station
place = get_place(to_station);
if place.tokens > global_info.station_tracks(to_station),
    fid = fopen('results/overcapasity.txt', 'a');
    fprintf(fid, '%s\t%d\t%d\t%s\n', string_HH_MM_SS(ctime), place.tokens, global_info.station_tracks(to_station), to_station);
    fclose(fid);
end;

%% general out reporting
tokID = tokenAny(to_station, 1);
colors = get_color(to_station, tokID); % colors(routenr, 'N' or 'S')
routnr = str2num(colors{1});

if ismember('L', colors),
  train_type = 'L';
elseif ismember('R', colors),
  train_type = 'R';
elseif ismember('F', colors),
  train_type = 'F';
else
  train_type = 'X';
end;

fid = fopen('results/run.txt', 'a');
fprintf(fid, '%s\t%s\t%s\t%s\t%d\t%s\t%s\n', string_HH_MM_SS(ctime), 'A', direction, train_type, routnr, string_HH_MM_SS(ctime), to_station);
fclose(fid);
