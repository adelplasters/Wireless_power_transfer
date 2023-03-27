%qua calcoliamo le mutue induttanze nel caso dei tre coils

function [M12, M23, M13, k12, k23, k13,Q1, Q2, Q3] = inductance_3coil(f,coil1, coil2, coil3, d12, d23, d13)
    mu = (4*pi)*1e-7;
    w = 2*pi*f; 

    r1 = 0.316;
    r2 = 0.316;
    r3 = 0.316;
    alfa1 = sqrt(r1*r2/((r1 + r2)^2) + d12^2);
    alfa2 = sqrt(r2*r3/((r2 + r3)^2) + d23^2);
    alfa3 = sqrt(r1*r3/((r1 + r3)^2) + d13^2);

    [K1,E1] = ellipke(alfa1);
    [K2,E2] = ellipke(alfa2); 
    [K3,E3] = ellipke(alfa3); 

    M12 = 2*mu*sqrt(r1*r2)*((1 - (alfa1^2)/2)*K1 - E1)/alfa1; 
    M23 = 2*mu*sqrt(r2*r3)*((1 - (alfa2^2)/2)*K2 - E2)/alfa2; 
    M13 = 2*mu*sqrt(r1*r3)*((1 - (alfa3^2)/2)*K3 - E3)/alfa3; 
    
    k12 = M12/sqrt(coil1.L*coil2.L); 
    k23 = M23/sqrt(coil2.L*coil3.L);
    k13 = M13/sqrt(coil1.L*coil3.L);

    coil1.Q = w*coil1.L./coil1.ESR;
    coil2.Q = w*coil2.L./coil2.ESR;
    coil3.Q = w*coil3.L./coil3.ESR;

    Q1 = coil1.Q;
    Q2 = coil2.Q;
    Q3 = coil3.Q;