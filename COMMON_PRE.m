function [fire, transition] = COMMON_PRE(transition)
% function [fire, trans] = COMMON_PRE(trans)
% disp(transition.name);
global global_info;
if ismember(transition.name, {'tInStavanger','tInSandnes','tInNaerbo','tInEgersund'}),
    fire = 1;
    return;
end;


tokID = tokenAny(transition.name(3:end),1); % Take out any token in the station name in the transition
colors = get_color(transition.name(3:end), tokID); % colors(routenr, 'N' or 'S')
routnr = str2num(colors{1}); % get the routnumber in colors


%train_type = char(colors(2));  % 'N' or 'S'
direction = char(transition.name(1));
ctime = current_time();
station = transition.name(3:end);

numOfTracks = global_info.station_tracks(station);
tracksN = global_info.tracks_north(station);
tracksS = global_info.tracks_south(station);

time=0;
if eq(direction,'S'),% South goning tranitions
  time = global_info.times_rogaland_south(global_info.stationnr(station),routnr);
  if strcmp(transition.name, 'SFSandnes'),
    % Take only out trains/tokens that is going to Egersund og Naerbo, and sends that token futhre
    tokID = tokenAnyColor(station,1,{'Egersund', 'Naerbo'});
  elseif strcmp(transition.name, 'SFNaerbo'),
    % Take only out trains/tokens that is going to Egersund, and sends that token futhre
    tokID = tokenAnyColor(station,1,{'Egersund'});
  else
    % Take only out trains/tokens that is going to South, and sends that token futhre
    tokID = tokenAnyColor(station,1,{'S'});
  end;

elseif eq(direction,'N'), % South goning tranitions
  time = global_info.times_rogaland_north(20-global_info.stationnr(station),routnr);
  % Take only out trains/tokens that is going to North, and sends that token futhre
  tokID = tokenAnyColor(station,1,{'N'});
end;
granted = request(transition.name, {transition.name(3:end),1});
if granted,
  fire = tokID;
else
  fire = 0;
end;
% Writes action to result file
if (fire > 0),
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
end;

% if and(eq(char(transition.name(1)),'N'), fire ~= 0),
%         disp('#############################');
%         disp(transition.name);
%         disp(tokID)
%         disp(string_HH_MM_SS(current_time()));
% end;
