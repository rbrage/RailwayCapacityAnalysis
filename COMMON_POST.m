function [] = COMMON_POST(transition)

global global_info;

%release all resources used by transition
release(transition.name);
if ismember(transition.name, {'tInStavanger','tInSandnes','tInNaerbo','tInEgersund'}),
    return;
end;

direction = char(transition.name(1));
ctime = current_time();
station = transition.name(3:end);

fid = fopen('results/run.txt', 'a');
fprintf(fid, '%s\t%s\t%s\t%s\n', string_HH_MM_SS(ctime), 'A', direction, station);
fclose(fid);


