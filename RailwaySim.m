% Main file

clear all; clc;

global global_info; %user data
% 24h of simultion
global_info.START_AT = [05 00 00]; % OPTION: start simulations at 10 AM
global_info.STOP_AT  = [26 59 59]; % OPTION: stop  simulations at 15 AM

global_info.DELTA_TIME = 60;  % delta_T is 1 minutes
global_info.times_rogaland_south =  dlmread('Stavanger_Egersund_traintimes.txt', '\t', 0, 1);%dlmread('test.txt', '\t', 0, 1);%
global_info.times_rogaland_north =  dlmread('Egersund_Stavanger_traintimes.txt', '\t', 0, 1);
global_info.last_route_traveled_North = 0;
global_info.last_route_traveled_South = 0;
global_info.next_train_type = {['North'];['South']};
[global_info.stations, global_info.traksnorth, global_info.trakssouth, global_info.stationtracks] = textread('Trainstations.txt', '%s %d %d %d');

initokensStavanger = size(global_info.times_rogaland_south(1, 1:end),2);
initokensSandnes = size(global_info.times_rogaland_north(13,1:end),2);
initokensNaerbo = size(global_info.times_rogaland_north(8,1:end),2);
initokensEgersund = size(global_info.times_rogaland_north(1,1:end),2);

pns = pnstruct('RailwaySim_pdf');

dyn.m0 = {'pGenStavanger', initokensStavanger, 'pGenSandnes', initokensSandnes, 'pGenNaerbo',initokensNaerbo,'pGenEgersund',initokensEgersund};%How many tokens that are in places

% Generates train times
dyn.ft = {'tInStavanger', 1,'tInSandnes', 1,'tInNaerbo',1,'tInEgersund',1 'allothers', 1}; %firering time [hh mm ss]
diff = time_diff(global_info.times_rogaland_south(1:end, 1));
for i = 1:length(diff),
    dyn.ft = [dyn.ft {strjoin(['SFrom', global_info.stations(i)], '') diff(i)}];
end;

diff = time_diff(global_info.times_rogaland_north(1:end, 1));
for i = length(diff):-1:1,
    dyn.ft = [dyn.ft {strjoin(['NFrom', global_info.stations(i+1)], '') diff(i)}];
end;

pni = initialdynamics(pns, dyn);

sim = gpensim(pni);
prnss(sim);
plotp(sim, global_info.stations);
