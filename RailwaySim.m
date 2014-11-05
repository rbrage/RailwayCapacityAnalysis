% Main file

clear all; clc;

global global_info; %user data
% 24h of simultion
global_info.START_AT = [00 00 00]; % OPTION: start simulations at 10 AM
global_info.STOP_AT  = [23 59 59]; % OPTION: stop  simulations at 15 AM

global_info.DELTA_TIME = 60;  % delta_T is 1 minutes
global_info.times_rogaland_south =  dlmread('Stavanger_Egersund_traintimes.txt', '\t', 0, 1);%dlmread('test.txt', '\t', 0, 1);%
%global_info.times_rogaland_north =  dlmread('Egersund_Stavanger_traintimes.txt', '\t', 0, 1);
global_info.last_route_traveled = 0;
global_info.next_train_type = [double('N') double('S')];
[global_info.stations, global_info.traksnorth, global_info.trakssouth, global_info.stationtracks] = textread('Trainstations.txt', '%s %d %d %d');

initokensStavanger = size(global_info.times_rogaland_south(1, 1:end),2);
%initokensSandnes = length(global_info.next_train_time_Sandnes);

pns = pnstruct('RailwaySim_pdf');

dyn.m0 = {'pGenStavanger', initokensStavanger+5};%, 'pGenSandnes', initokensSandnes};%How many tokens that are in places

% Generates train times
dyn.ft = {'tInStavanger', 1, 'allothers', 1}; %firering time [hh mm ss]
diff = time_diff(global_info.times_rogaland_south(1:end, 1));
for i = 1:length(diff),
    dyn.ft = [dyn.ft {strjoin(['SFrom', global_info.stations(i)], '') diff(i)}];
end;

pni = initialdynamics(pns, dyn);

sim = gpensim(pni);
prnss(sim);
plotp(sim, global_info.stations);
