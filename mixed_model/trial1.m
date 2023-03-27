%in this script I will try to make some possible configurations working
%together:
%first of all --> Rx should be a PCB type, because it is the smallest
%implementation possible (Square_Shaped_PCB):
dist = [5e-2,6e-2,10e-2,13e-2,18e-2,20e-2];
delta = linspace(0,18e-2,100);


Rx = Solenoid(0.1,100e3,0.7e-2,3,1e-3,0.6e-3);

Tx = Solenoid(1,100e3,22e-2,158,10e-2,0.6e-3);


[M,k] = mutual_inductance(Rx,Tx,'lateral');


[link_eff,Pmn] = link_efficiency(1,k,Tx,Rx,'lateral',100);

 

    