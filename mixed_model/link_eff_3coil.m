%provo ad implementare la link efficiency 3 - coil

function [link_eff_3coil, Pmn] = link_eff_3coil(Is,f,coil1,coil2,coil3,k12, k23,k13,Rload)

%intanto proviamo a calcolare le impedenze riflesse

%Zrx = (k23^2)*coil2.Q*coil3.Q*QL*coil2.ESR/(QL + coil3.Q);
w =  2*pi*f;
QL = Rload/(w*coil3.L);
QRxL = coil3.Q*QL/(QL + coil3.Q);


%ZA = ((k12^2)*coil1.Q*coil2.Q*coil1.ESR*1)/((k23^2)*coil2.Q*QRxL+1);

link_eff_3coil = (QRxL/QL)*(k23^2)*coil2.Q*QRxL/((k23^2)*coil2.Q*QRxL+1)*(k12^2)*coil1.Q*coil2.Q/((k12^2)*coil1.Q*coil2.Q + (k23^2)*coil2.Q*QRxL + 1);


Pmn = (Is^2)*coil1.ESR*QRxL*((k23^2)*coil2.Q*QRxL)*((k12^2)*coil1.Q*coil2.Q)/2*QL*((k23^2)*coil2.Q*QRxL + 1)^2;    