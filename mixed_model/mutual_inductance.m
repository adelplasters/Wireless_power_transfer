%mutual inductance and coupling coefficient function

function [M,k] = mutual_inductance(Rx,Tx,dist)
    
    a = 20e-2; %Tx radius
    b = 0.7e-2; %Rx radius
    mu0 = (4*pi)*1e-7;

    %coaxial case 

    N = sqrt(4*a*b/(((a+b)^2) + dist^2));
    [K,E] = ellipke(N);
    G = ((2/N) - N)*K - (2/N)*E;
    M = mu0*sqrt(a*b)*G;

    k = M/sqrt(Tx.L * Rx.L);

end 