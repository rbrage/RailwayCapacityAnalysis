function [] = init_results_files()
fid = fopen('results/run.txt', 'w');
fprintf(fid, '%s\t%s\t%s\t%s\n', 'Time', 'A/D' , 'Direction', 'Type', 'Routnr', 'Schedule', 'Station');
fclose(fid);

fid = fopen('results/run_south.txt', 'w');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\n', 'Time', 'A/D' , 'Direction', 'Type', 'Routnr', 'Schedule', 'Station');
fclose(fid);

fid = fopen('results/run_north.txt', 'w');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\n', 'Time', 'A/D' , 'Direction', 'Type', 'Routnr', 'Schedule', 'Station');
fclose(fid);

fid = fopen('results/delays.txt', 'w');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'Time', 'Schedule', 'Direction', 'Type', 'Routnr', 'From Station', 'To Station','Transition');
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

fid = fopen('results/tGenMoi.txt', 'w');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'Time', 'GENIN', 'Direction', 'TrainType', 'StopPlace','Time', 'Routenr');
fclose(fid);

fid = fopen('results/tGenFeigth.txt', 'w');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\n', 'Time', 'GENIN', 'Direction', 'TrainType', 'StopPlace');
fclose(fid);

fid = fopen('results/overcapasity.txt', 'w');
fprintf(fid, '%s\t%s\t%s\t%s\n', 'Time', 'Current trains', 'Max trains', 'Place');
fclose(fid);