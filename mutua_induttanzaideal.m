%questa formulazione è valida solo se W << diameter
function [M, k] = mutua_induttanza(coil1, coil2, dist)

    mu0 = (4*pi)*1e-7;


    a =zeros(1, coil1.n);
    b = zeros(1, coil2.n); 

    for x=1:coil1.n

        a(x) = coil1.dout/2 - (x - 1)*(coil1.W+coil1.S) - coil1.W/2; 
    end 

     for y=1:coil2.n

        b(y) = coil2.dout/2 - (y - 1)*(coil2.W+coil2.S) - coil2.W/2; 
    end 

    x = 0;
    y = 0;

    gamma = zeros(coil1.n, coil2.n); 
    m = zeros(coil1.n, coil2.n);
    M = 0; 

    for x=1:coil1.n
        for y=1:coil2.n
            gamma(x,y) = 2*a(x)*b(y)/(a(x)^2 + b(y)^2 + dist^2); 

            factorM1 = mu0*pi*(a(x)^2)*(b(y)^2)/(2*(a(x)^2 + b(y)^2 + dist^2)^(3/2));
            factorM2 = 1 + (15/32)*gamma(x,y)^2 + (315/1024)*gamma(x,y)^4;

            m(x,y) = factorM1*factorM2; 

            M = M + ((4/pi)^(1 + coil2.dout/coil1.dout))*m(x,y); 



        end 
    end

k = M/sqrt(coil1.L*coil2.L); 
