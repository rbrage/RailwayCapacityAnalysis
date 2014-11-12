function [fire, transition] = COMMON_PRE(transition)
% function [fire, trans] = COMMON_PRE(trans)
% disp(transition);
global global_info;
if ismember(transition.name, {'tInStavanger','tInSandnes','tInNaerbo','tInEgersund', 'tOutStavangerS','tOutSandnes','tOutNaerbo','tOutEgersund'}),
    fire = 1;
    return;
end;

%train_type = char(colors(2));  % 'N' or 'S'
direction = char(transition.name(1));
ctime = current_time();
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
if (tokID == 0),
    fire = 0;
    return;
  else
    colors = get_color(from_station, tokID);
    routnr = str2num(colors{1});
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
  fid = fopen('results/run_collisions.txt', 'a');
  fprintf(fid, '%s\t %s\t %s\t %s\t %s\t %d\t %s\n', string_HH_MM_SS(ctime), direction, from_station, to_station, string_HH_MM_SS(convert_militery_time(time, 2)),routnr, transition.name);
  fclose(fid);
  fire = 0;
  return;
end;

% tokID = tokenAny(from_station, 1); % Take out any token in the station name in the transition
% colors = get_color(from_station, tokID); % colors(routenr, 'N' or 'S')
% routnr = str2num(colors{1}); % get the routnumber in colors
%
% numOfTracks = global_info.station_tracks(station);
% tracksN = global_info.tracks_north(station);
% tracksS = global_info.tracks_south(station);

%
% tokens = tokIDs(from_station);
%
% if length(tokens) == 0,
%         fire = 0;
%         return
% end;
%
% col = {};
% tokdir = 'X';
% tokend = 'none';
% tokID = 0;
%
% for i = 1:length(tokens),
%     col = get_color(from_station, tokens(i));
%     for j = 1:length(col),
%         if strcmp(col{j}, 'S') || strcmp(col{j}, 'N'),
%             tokdir = col{j};
%         end;
%
%         if strcmp(col{j}, 'Stavanger') || strcmp(col{j}, 'Egersund') || strcmp(col{j}, 'Sandnes') || strcmp(col{j}, 'Naerbo'),
%             tokend = col{j};
%         end;
%     end;
%
%     if strcmp(from_station, tokend),
%         continue;
%     end;
%
%     if strcmp(direction, tokdir),
%         tokID = tokens(i);
%         disp('-----------------------------');
%         col
%         disp(transition.name);
%         disp('Fireing token:');
%         disp(tokID);
%         disp('endstation');
%         disp(tokend);
%         disp('Diection');
%         disp(tokdir);
%         break;
%     end;
% end;

% if strcmp(direction, 'N'),
%     [tokID, valid] = tokenAnyColor(from_station, 1, 'N');
%     if (valid ~= 1),
%         fire = 0;
%         return;
%     end;
%     disp('------------------');
%     col = get_color(from_station, tokID);
%     for i = 1:length(col),
%         if (strcmp(char(col{i}), char('S')) == 1)
%             fire = 0;
%             disp('Fire deverted');
%             return;
%         end;
%     end;
%
%     if (tokID ~= 0),
%       disp('----------------------------------');
%       transition.name
%       from_station
%       colors = get_color(from_station, tokID) % colors(routenr, 'N' or 'S')
%       routnr = str2num(colors{1});
%     end;
% elseif strcmp(from_station, 'Naerbo'),
%     [tokID, valid] = tokenAnyColor(from_station, 1, 'Egersund');
%     if valid ~= 1,
%         fire = 0;
%         return;
%     end;
%     disp('------------------');
%     col = get_color(from_station, tokID);
%     for i = 1:length(col),
%         if (strcmp(char(col{i}), char('N')) == 1)
%             fire = 0;
%             disp('Fire deverted');
%             return;
%         end;
%     end;
% elseif strcmp(from_station, 'Sandnes'),
%     [tokID, valid] = tokenAnyColor(from_station, 1, {'Egersund', 'Naerbo'});
%     if valid ~= 1,
%         fire = 0;
%         return;
%     end;
%     disp('------------------');
%     col = get_color(from_station, tokID);
%     for i = 1:length(col),
%         if (strcmp(char(col{i}), char('N')) == 1)
%             fire = 0;
%             disp('Fire deverted');
%             return;
%         end;
%     end;
% elseif strcmp(direction, 'S'),
%     [tokID, valid] = tokenAnyColor(from_station, 1, 'S');
%     if valid ~= 1,
%         fire = 0;
%         return;
%     end;
%     disp('------------------');
%     col = get_color(from_station, tokID);
%     for i = 1:length(col),
%         if (strcmp(char(col{i}), char('N')) == 1)
%             fire = 0;
%             disp('Fire deverted');
%             return;
%         end;
%     end;
% else
%     fire = 0;
%     disp('Noe har eg ikke tenkt p�!');
%     return;
% end;



% if strcmp(direction, 'S'),% South goning tranitions
%   if strcmp(transition.name, 'SFSandnes'),
%     % Take only out trains/tokens that is going to Egersund og Naerbo, and sends that token futhre
%     [tokID, valid] = tokenWOAllColor(from_station,1,{'N', char('Sandnes')});
%     if (tokID ~= 0),
%       disp('----------------------------------');
%       transition.name
%       from_station
%       valid
%       colors = get_color(from_station, tokID) % colors(routenr, 'N' or 'S')
%       routnr = str2num(colors{1});
%     end;
%
%   elseif strcmp(transition.name, 'SFNaerbo'),
%     % Take only out trains/tokens that is going to Egersund, and sends that token futhre
%     tokID = tokenAnyColor(from_station,1,{'Egersund'});
%   else
%     % Take only out trains/tokens that is going to South, and sends that token futhre
%     tokID = tokenAnyColor(from_station,1,{'S'});
%
%   end;
% elseif strcmp(direction,'N'), % South goning tranitions
%   % Take only out trains/tokens that is going to North, and sends that token futhre
%   tokID = tokenWOAnyColor(from_station,1,{'N'});
%
%   if strcmp(from_station, 'Sandnes'),
%
%   end;
% end;

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
