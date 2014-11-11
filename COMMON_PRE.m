function [fire, transition] = COMMON_PRE(transition)
% function [fire, trans] = COMMON_PRE(trans)
% disp(transition);
global global_info;
if ismember(transition.name, {'tInStavanger','tInSandnes','tInNaerbo','tInEgersund'}),
    fire = 1;
    return;
end;

%train_type = char(colors(2));  % 'N' or 'S'
direction = char(transition.name(1));
ctime = current_time();
station = transition.name(3:end);

if eq(direction, 'N'),
    from_station = char(global_info.stations(global_info.stationnr(station) + 1));
else
    from_station = station;
end;

% tokID = tokenAny(from_station, 1); % Take out any token in the station name in the transition
% colors = get_color(from_station, tokID); % colors(routenr, 'N' or 'S')
% routnr = str2num(colors{1}); % get the routnumber in colors
% 
% numOfTracks = global_info.station_tracks(station);
% tracksN = global_info.tracks_north(station);
% tracksS = global_info.tracks_south(station);


if eq(direction, 'S'),% South goning tranitions
  if strcmp(transition.name, 'SFSandnes'),
    % Take only out trains/tokens that is going to Egersund og Naerbo, and sends that token futhre
    tokID = tokenAnyColor(from_station,1,{'Egersund', 'Naerbo'});
  elseif strcmp(transition.name, 'SFNaerbo'),
    % Take only out trains/tokens that is going to Egersund, and sends that token futhre
    tokID = tokenAnyColor(from_station,1,{'Egersund'});
  else
    % Take only out trains/tokens that is going to South, and sends that token futhre
    tokID = tokenAnyColor(from_station,1,{'S'});
  end;

elseif eq(direction,'N'), % South goning tranitions
  % Take only out trains/tokens that is going to North, and sends that token futhre
  tokID = tokenAnyColor(from_station,1,{'N'});
end;

% if no token is found return
if (tokID == 0),
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
    time = global_info.times_rogaland_north(20-global_info.stationnr(from_station),routnr);
end;

% checks if the resource is granted
if granted,
%     transition.override = 1;
%     transition.new_colors = colors;
    transition.selected_tokens = tokID;
  fire = 1;
else
  fire = 0;
  return;
end;


time=0;
colors = get_color(from_station, tokID); % colors(routenr, 'N' or 'S')
routnr = str2num(colors{1}); % get the routnumber in colors
if eq(direction, 'S'),
    time = global_info.times_rogaland_south(global_info.stationnr(from_station),routnr);
else
    time = global_info.times_rogaland_north(20-global_info.stationnr(from_station),routnr);
end;

% Writes action to result file
fid = fopen('results/run.txt', 'a');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t|%d\n', string_HH_MM_SS(ctime), 'D', direction, station, string_HH_MM_SS(convert_militery_time(time, 2)),granted);
fclose(fid);
if eq(direction,'S'),
  fid = fopen('results/run_south.txt', 'a');
  fprintf(fid, '%s\t%s\t%s\t%s\t%s\t|%d\t|%d\n', string_HH_MM_SS(ctime), 'D', direction, station, string_HH_MM_SS(convert_militery_time(time, 2)),routnr,granted);
  fclose(fid);
else
  fid = fopen('results/run_north.txt', 'a');
  fprintf(fid, '%s\t%s\t%s\t%s\t%s\t|%d\t|%d\n', string_HH_MM_SS(ctime), 'D', direction, station, string_HH_MM_SS(convert_militery_time(time, 2)),routnr,granted);
  fclose(fid);
end;

% if and(eq(char(transition.name(1)),'N'), fire ~= 0),
%         disp('#############################');
%         disp(transition.name);
%         disp(tokID)
%         disp(string_HH_MM_SS(current_time()));
% end;
