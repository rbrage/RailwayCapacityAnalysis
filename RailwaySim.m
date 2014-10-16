% Main file

clear all; clc;

global global_info; %user data
% 24h of simultion
global_info.START_AT = [0 0 0]; % OPTION: start simulations at 10 AM
global_info.STOP_AT  = [23 59 59]; % OPTION: stop  simulations at 15 AM
global_info.DELTA_TIME = 60;  % delta_T is 1 minutes

png = pnstruct('RailwaySim_pdf');

dyn.m0 = {'pS45', 2};%How many tokens that are in places
dyn.ft = {'t44S', [5 01 0]}; %firering time [hh mm ss]

pni = initialdynamics(pns, dyn);

sim = gpensim(pni);
prnss(sim);
plotp(sim, {'pS45'});
