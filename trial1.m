%in this script I will try to make some possible configurations working
%together:
%first of all --> Rx should be a PCB type, because it is the smallest
%implementation possible (Square_Shaped_PCB):

Rx = Square_Shaped_PCB(16e-3,250e-6,4,0,1.75e-3,13.56e6,0,1.4e-2,'square');

Tx = Solenoid(40e-2,4,6.4,0.3e-3);

[M,k] = mutual_inductance(Rx,Tx,'lateral');

[link_eff] = link_efficiency(k,Tx,Rx,'lateral');

figure 
plot(k,link_eff)
xlabel('coupling coefficient')
ylabel('link efficiency')

    