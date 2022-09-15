%funzione per calcolare la link efficiency e il Pmn delivered to Rx 


function [link_eff_3coil, P13] = Link_eff(coil1, coil2, coil3, k12, k23, k13, Q1, Q2, Q3, Q3L, QL)

    Vs = 5; 

    factor1 = (k12^2)*Q1*Q2;
    factor2 = (k23^2)*Q2*Q3L; 
    factor3 = (k13^2)*Q1*Q3L; %qua non sono sicura del valore di Q3L perchè sull'articlo è Q4L;
    A = 1 + (k12^2)*Q1*Q2 + (k23^2)*Q2*Q3L + (k13^2)*Q1*Q3L; 
    B = 2*Q1*Q2*Q3L*k12*k13*k23; 
    teta = atan(B/A);

    link_eff_3coil = ((factor1*factor2 + factor3)*Q3L)/(cos(teta)*(1 + factor2)*sqrt(A^2 + B^2)*QL); 

    P13 = (Vs^2)*(factor1*factor2 + factor3)*Q3L/(2*coil1.Rdc*(A^2 + B^2)*QL); 
   
