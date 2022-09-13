%script per calcolare la mutua induttanza tra due parallel single-turn circular
%coils con raggi r1 e r2, la self induttanza, il coefficiente di
%accoppiamento 
function [M12, M23, M13, Lself, k12, k23, k13, Q2, Q3, Q3L] = inductance(coil1, coil2, coil3, dij)

    mu = 0; 
    omega0 = 0; 

    r1 = coil1.w/2; 
    r2 = coil2.w/2;
    r3 = coil3.w/2; 
    alfa = sqrt(ri*rj/((ri + rj)^2) + dij^2);

    [K,E] = ellipke(alfa); 
    M12 = 2*mu*sqrt(r1*r2)*((1 - (alfa^2)/2)*K - E)/alfa; 
    M23 = 2*mu*sqrt(r2*r3)*((1 - (alfa^2)/2)*K - E)/alfa; 
    M13 = 2*mu*sqrt(r1*r3)*((1 - (alfa^2)/2)*K - E)/alfa; 
    


    k12 = M12/sqrt(L1*L2); 
    k23 = M23/sqrt(L2*L3);
    k13 = M13/sqrt(L1*L3);



    %self inductance 

    Lself = sum(Mij) + sum(Li); 

    %la R2 dovrebbe contenere anche la Rs!!!!

    %quality factors, al momento calcolata con Rdc

    Q2 = omega0*coil2.L/coil2.Rdc;
    Q3 = omega0*coil3.L/coil3.Rdc;

    Rload = ???
    QL = Rload/(omega0*coil3.L); %è il Qload
    Q3L = Q3*QL/(Q3 + QL);
