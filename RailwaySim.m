% Main file

clear all; clc;

global global_info; %user data
global_info.PRINT_LOOP_NUMBER = 1;
global_info.STOP_AT = 50;

pns = pnsstructur('RailwaySim_pdf');

dyn.m0 = {};
dyn.ft = {};
