%script per calcolare la mutua induttanza tra due parallel single-turn circular
%coils con raggi r1 e r2, la self induttanza, il coefficiente di
%accoppiamento 


function [M12, M23, M13, Lself, k12, k23, k13, Q1, Q2, Q3, Q3L, QL] = inductance(coil1, coil2, coil3, d12, d23, d13)

    mu = (4*pi)*1e-7;
    f0 = 13.56*1e6; 
    omega0 = 2*pi*f0; 


    r1 = coil1.w/2; 
    r2 = coil2.w/2;
    r3 = coil3.w/2; 
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



    %self inductance 

    Lself = M12 + M23 + M13 + coil1.L + coil2.L + coil3.L; 

    %la R2 dovrebbe contenere anche la Rs!!!!

    %quality factors, al momento calcolata con Rwwc
    
    coil1.Q = omega0*coil1.L./coil1.Rwwc;
    coil2.Q = omega0*coil2.L./coil2.Rwwc;
    coil3.Q = omega0*coil3.L./coil3.Rwwc;

    Q1 = coil1.Q;
    Q2 = coil2.Q;
    Q3 = coil3.Q;

    Rload = 200; %deve essere tra 10 Ohm e 10k
    QL = Rload/(omega0*coil3.L); %è il Qload
    Q3L = Q3*QL/(Q3 + QL);
