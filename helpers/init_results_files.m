function [] = init_results_files()
fid = fopen('results/run.txt', 'w');
fprintf(fid, '%s\t%s\t%s\t%s\n', 'Time', 'Type', 'Direction', 'Station');
fclose(fid);
fid = fopen('results/run_south.txt', 'w');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\n', 'Time', 'Type', 'Direction', 'Station','Schedule', 'Routnr');
fclose(fid);
fid = fopen('results/run_north.txt', 'w');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\n', 'Time', 'Type', 'Direction', 'Station','Schedule', 'Routnr');
fclose(fid);
fid = fopen('results/delays.txt', 'w');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'Time', 'Schedule', 'Routnr', 'Type', 'Direction', 'From Station', 'To Station');
fclose(fid);
fid = fopen('results/tGenStavanger.txt', 'w');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'Time', 'GENIN', 'Direction', 'TrainType', 'StopPlace', 'Time', 'Routenr');
fclose(fid);
fid = fopen('results/tGenKristiansand.txt', 'w');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'Time', 'GENIN', 'Direction', 'TrainType', 'StopPlace','Time', 'Routenr');
fclose(fid);
fid = fopen('results/tGenDrammen.txt', 'w');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'Time', 'GENIN', 'Direction', 'TrainType', 'StopPlace','Time', 'Routenr');
fclose(fid);
