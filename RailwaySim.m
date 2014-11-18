% Main file

clear all; clc;

global global_info; %user data

% init result file
init_results_files();
h = waitbar(0,'The trains are leaving. Toooot Toooot!');
global_info.ctime = 0;
% timing of simultion
global_info.START_AT = [00 00 00]; % OPTION: start simulations at 10 AM
global_info.STOP_AT  = [48 00 00]; % OPTION: stop  simulations at 15 AM
global_info.STOP_se = global_info.STOP_AT(1)*60*60 + global_info.STOP_AT(2)*60;


global_info.DELTA_TIME = 60;  % delta_T is 1 minutes
global_info.freight_generation_delay = 60*60*12;

global_info.freight_generation_ganddal = {'334', 'Kristiansand', '820', ...
    'Kristiansand', '922', 'Kristiansand', '1052', 'Kristiansand', '1332', ...
    'Kristiansand', '1723', 'Kristiansand', '1822', 'Kristiansand', ...
    '2022', 'Kristiansand'}; % ,'1922', 'Gulskogen','1622', 'Gulskogen','1652', 'Gulskogen','1422', 'Gulskogen','1522', 'Gulskogen','1222', 'Gulskogen','1302', 'Gulskogen','1500', 'Gulskogen', '1600', 'Gulskogen', '1700', 'Gulskogen'};
global_info.freight_generation_gulskogen = {'22', 'Ganddal', '941', ...
    'Ganddal', '1223', 'Ganddal', '1523', 'Ganddal', ...
    '2039', 'Ganddal', '2112', 'Ganddal', '2155', 'Ganddal',...
    '2222', 'Ganddal'}; %, '0222', 'StavangerS', '0432', 'Neslandsvatn','1532', 'Ganddal', '1432', 'Ganddal', '1332', 'Ganddal','1200', 'Ganddal', '1405', 'Ganddal', '1305', 'Ganddal', '1135', 'Ganddal'};

global_info.times_rogaland_south = dlmread('db/Stavanger_Egersund_traintimes.txt', '\t', 0, 1);%dlmread('db/test.txt', '\t', 0, 1); %
global_info.times_rogaland_north = dlmread('db/Egersund_Stavanger_traintimes.txt', '\t', 0, 1);%dlmread('db/test2.txt', '\t', 0, 1);%
global_info.times_regional_south = dlmread('db/Stavanger_Drammen_traintimes.txt', '\t', 0, 1);
global_info.times_regional_north = dlmread('db/Drammen_Stavanger_traintimes.txt', '\t', 0, 1);

global_info.last_route_traveled_North = 0;
global_info.last_route_traveled_South = 0;
global_info.last_Regional_route_traveled_South = 0;

%Generating train times for local trains.
global_info.timesToFireStavanger_Local = containers.Map('KeyType','double','ValueType','double');
for i = 1:size(global_info.times_rogaland_south,2),
  global_info.timesToFireStavanger_Local(convert_militery_time(global_info.times_rogaland_south(1, i),2)) = i;
end;
global_info.timeToFireEgersund = containers.Map('KeyType','double','ValueType','double');
global_info.timeToFireNaerbo = containers.Map('KeyType','double','ValueType','double');
global_info.timeToFireSandnes = containers.Map('KeyType','double','ValueType','double');
for i = 1:size(global_info.times_rogaland_north,2),
    global_info.timeToFireEgersund(convert_militery_time(global_info.times_rogaland_north(1, i),2)) = i;
    global_info.timeToFireNaerbo(convert_militery_time(global_info.times_rogaland_north(8, i),2)) = i;
    global_info.timeToFireSandnes(convert_militery_time(global_info.times_rogaland_north(13, i),2)) = i;
end;

% Regional trains
global_info.timeToFireKristiandsand_North = containers.Map('KeyType','double','ValueType','double');
global_info.timeToFireKristiandsand_South = containers.Map('KeyType','double','ValueType','double');
global_info.timeToFireDrammen = containers.Map('KeyType','double','ValueType','double');
global_info.timeToFireStavanger_Regional = containers.Map('KeyType','double','ValueType','double');
global_info.timeToFireMoi = containers.Map('KeyType','double','ValueType','double');
%Generating train times for regional trains going north
for i = 1:size(global_info.times_regional_north,2),
  global_info.timeToFireDrammen(convert_militery_time(global_info.times_regional_north(1, i),2)) = i;
  global_info.timeToFireKristiandsand_North(convert_militery_time(global_info.times_regional_north(37, i),2)) = i;
end;

%Generating trains for regional trains going south
for i = 1:size(global_info.times_regional_south,2),
  global_info.timeToFireStavanger_Regional(convert_militery_time(global_info.times_regional_south(1, i),2)) = i;
  global_info.timeToFireKristiandsand_South(convert_militery_time(global_info.times_regional_south(34, i),2)) = i;
  global_info.timeToFireMoi(convert_militery_time(global_info.times_regional_south(23, i),2)) = i;
end;


% loads information about the stations
[global_info.stations, tracksnorth, trackssouth, stationtracks, time_n, time_s] = textread('db/Trainstations.txt', '%s %d %d %d %d %d');
% making a station ID
global_info.stationnr = containers.Map(global_info.stations, 1:length(global_info.stations));
% storing number of tracks on a station
global_info.station_tracks = containers.Map(global_info.stations, stationtracks);
% storing number of tracks going north
global_info.tracks_north = containers.Map(global_info.stations, tracksnorth);
% storing number of tracks going south
global_info.tracks_south = containers.Map(global_info.stations, tracksnorth);

pns = pnstruct('RailwaySim_pdf');

dyn.m0 = {'pGenStavanger', 1,'pGenSandnes', 1, 'pGenNaerbo', 1,'pGenEgersund', 1, 'pGenMoi', 1, 'pGenKristiansand', 1, 'pGenDrammen',1, 'pGenGulskogen', 1, 'pGenGanddal', 1};%How many tokens that are in places

% Generates train times
dyn.ft = {'allothers', 1}; %firering time [hh mm ss]

for i = 1:length(time_s)-1,
    dyn.ft = [dyn.ft {strjoin(['SF', global_info.stations(i)], '') time_s(i)-1}];
end;

for i = 1:length(time_n)-1,
    dyn.ft = [dyn.ft {strjoin(['NT', global_info.stations(i)], '') time_n(i+1)-1}];
end;

% disp(dyn.ft);

% generates resorces to lock a train track when in use.
dyn.re = {};
for i = 1:length(global_info.stations),
    if (global_info.tracks_south(char(global_info.stations(i))) == 1),
        dyn.re = [dyn.re {strjoin(['', global_info.stations(i)], '') 1 inf}];
    else
        dyn.re = [dyn.re {strjoin(['NT', global_info.stations(i)], '') 1 inf}];
        dyn.re = [dyn.re {strjoin(['SF', global_info.stations(i)], '') 1 inf}];
    end;
end;

pni = initialdynamics(pns, dyn);
sim = gpensim(pni);

%cotree(pni,1,1);
%prnss(sim);
prnfinalcolors(sim);
%prnschedule(sim);
plotp(sim, global_info.stations);
close(h);
