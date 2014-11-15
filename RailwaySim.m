% Main file

clear all; clc;

global global_info; %user data

% init result file
init_results_files();

% 24h of simultion
global_info.START_AT = [04 30 00]; % OPTION: start simulations at 10 AM
global_info.STOP_AT  = [30 59 59]; % OPTION: stop  simulations at 15 AM

global_info.DELTA_TIME = 60;  % delta_T is 1 minutes
global_info.times_rogaland_south = dlmread('db/Stavanger_Egersund_traintimes.txt', '\t', 0, 1);%dlmread('db/test.txt', '\t', 0, 1); %
global_info.times_rogaland_north = dlmread('db/Egersund_Stavanger_traintimes.txt', '\t', 0, 1);%dlmread('db/test2.txt', '\t', 0, 1);%
global_info.times_regional_south = dlmread('db/Stavanger_Drammen_traintimes.txt', '\t', 0, 1);
global_info.times_regional_north = dlmread('db/Drammen_Stavanger_traintimes.txt', '\t', 0, 1);

global_info.last_route_traveled_North = 0;
global_info.last_route_traveled_South = 0;
global_info.last_Regional_route_traveled_South = 0;

%Generating train times for local trains.
global_info.timeToFireEgersund = containers.Map('KeyType','double','ValueType','double');
global_info.timeToFireNaerbo = containers.Map('KeyType','double','ValueType','double');
global_info.timeToFireSandnes = containers.Map('KeyType','double','ValueType','double');
for i = 1:size(global_info.times_rogaland_north,2),
    global_info.timeToFireEgersund(convert_militery_time(global_info.times_rogaland_north(1, i),2)) = i;
    global_info.timeToFireNaerbo(convert_militery_time(global_info.times_rogaland_north(8, i),2)) = i;
    global_info.timeToFireSandnes(convert_militery_time(global_info.times_rogaland_north(13, i),2)) = i;
end;

global_info.timeToFireKristiandsand_North = containers.Map('KeyType','double','ValueType','double');
global_info.timeToFireKristiandsand_South = containers.Map('KeyType','double','ValueType','double');
global_info.timeToFireDrammen = containers.Map('KeyType','double','ValueType','double');
global_info.timeToFireStavanger_Regional = containers.Map('KeyType','double','ValueType','double');
global_info.timeToFireMoi = containers.Map('KeyType','double','ValueType','double');

%Generating train times for regional trains going north
for i = 1:size(global_info.times_regional_north,2),
%  global_info.timeToFireDrammen(convert_militery_time(global_info.times_regional_north(1, i),2)) = i;
  global_info.timeToFireKristiandsand_North(convert_militery_time(global_info.times_regional_north(37, i),2)) = i;
end;

%Generating trains for regional trains going south
for i = 1:size(global_info.times_regional_south,2),
  global_info.timeToFireStavanger_Regional(convert_militery_time(global_info.times_regional_south(1, i),2)) = i;
  global_info.timeToFireKristiandsand_South(convert_militery_time(global_info.times_regional_south(34, i),2)) = i;
  %global_info.timeToFireMoi(convert_militery_time(global_info.times_regional_north(1, i),2)) = i;
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

dyn.m0 = {'pGenStavanger', 1,'pGenSandnes', 1, 'pGenNaerbo', 1,'pGenEgersund', 1, 'pGenKristiansand', 1};%How many tokens that are in places

% Generates train times
dyn.ft = {'tInStavanger', 1,'tInSandnes', 1,'tInNaerbo',1,'tInEgersund',1, 'tInKristiansand',1, 'allothers', 1}; %firering time [hh mm ss]

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
