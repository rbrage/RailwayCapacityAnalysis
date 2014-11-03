% Main file

clear all; clc;

global global_info; %user data
% 24h of simultion
global_info.START_AT = [04 59 00]; % OPTION: start simulations at 10 AM
global_info.STOP_AT  = [05 32 00]; % OPTION: stop  simulations at 15 AM
%global_info.STOP_AT  = 3;
global_info.DELTA_TIME = 60;  % delta_T is 1 minutes
global_info.next_train_time = [[05 00 00];[05 16 00];[05 31 00]];
global_info.next_train_type = [double('N') double('S')];
initokens = length(global_info.next_train_time);

pns = pnstruct('RailwaySim_pdf');

dyn.m0 = {'pGenStavanger', initokens};%How many tokens that are in places
dyn.ft = {'allothers', [00 01 00]}; %firering time [hh mm ss]

pni = initialdynamics(pns, dyn);

sim = gpensim(pni);
prnss(sim);
plotp(sim, {'Stavanger', 'Paradis', 'Mariero', 'Jattavagen',...
    'Gausel', 'SandnesSentrum', 'Sandnes'});
