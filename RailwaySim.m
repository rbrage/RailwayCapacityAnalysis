% Main file

clear all; clc;

global global_info; %user data
% 24h of simultion
global_info.START_AT = [00 00 00]; % OPTION: start simulations at 10 AM
global_info.STOP_AT  = [23 59 59]; % OPTION: stop  simulations at 15 AM
global_info.DELTA_TIME = 60;  % delta_T is 1 minutes

pns = pnstruct('RailwaySim_pdf');

dyn.m0 = {'Stavanger', 2};%How many tokens that are in places
dyn.ft = {'allothers', [00 10 00]}; %firering time [hh mm ss]

pni = initialdynamics(pns, dyn);

sim = gpensim(pni);
prnss(sim);
plotp(sim, {'Stavanger', 'Sandnes'});
