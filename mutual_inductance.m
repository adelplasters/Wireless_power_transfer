%mutual inductance and coupling coefficient function

function [M,k] = mutual_inductance(Rx,Tx,caso)
    
    a = 20e-2; %Tx radius
    b = 0.7e-2; %Rx radius
    mu0 = (4*pi)*1e-7;
    delta = 30e-2; %centre - centre distance
    dist = linspace(3e-2,10e-2,100);
    N = zeros(100);
    K = zeros(100);
    E = zeros(100);
    G = zeros(100);
    M = zeros(100);
    k = zeros(100);
     

    switch caso
    %coaxial case 

        case 'coaxial'
             for i=1:100
               N(i) = sqrt(4*a*b/(((a+b)^2) + dist(i)^2));
               [K(i),E(i)] = ellipke(N(i));
               G(i) = ((2/N(i)) - N(i))*K(i) - (2/N(i))*E(i);
               M(i) = mu0*sqrt(a*b)*G(i);

               k(i) = M(i)/sqrt(Tx.L * Rx.L);

              end 

    %lateral misalignment 
        case 'lateral'
            for i=1:100
                beta = @(phi) atan(delta.*sin(phi)./(b + delta.*cos(phi)));
                blat = @(phi) sqrt((b^2)+(delta.^2)+2*delta.*b*cos(phi));
                Nlat = @(phi) sqrt(4*a*blat(phi))/(((a + blat(phi))^2) + dist^2);
        %[Klat,~] = @(phi) ellipke(Nlat(phi));
        %Glat = @(phi) ((2/Nlat(phi)) - Nlat(phi))*Klat - (2/Nlat(phi))*Elat;
                Glat = @(x)(2./(x) - x).*myellipk(x.^2) - (2./(x)).*myellipe(x.^2);

                factor1 = mu0*a*b/(2*pi);
                fun = @(x) (cos(beta(x)).*Glat(x)./(sqrt(a.*blat(x))));
                M = factor1*integral(fun,0,1);
            end 
        
        k = M./sqrt(Tx.L*Rx.L);
        %fun = @(phi)(factor1*(cos(atan(delta*sin(phi)./(b + delta*cos(phi))))*(((2./(sqrt(4*a*(sqrt((b.^2)+(delta.^2)+2*delta*b*cos(phi))))./(((a + (sqrt((b.^2)+(delta.^2)+2*delta*b*cos(phi)))).^2) + dist.^2))) - (sqrt(4*a*(sqrt((b.^2)+(delta.^2)+2*delta*b*cos(phi))))./(((a + (sqrt((b.^2)+(delta.^2)+2*delta*b*cos(phi)))).^2) + dist.^2)))*Klat - (2./(sqrt(4*a*(sqrt((b.^2)+(delta.^2)+2*delta*b*cos(phi))))./(((a + (sqrt((b.^2)+(delta.^2)+2*delta*b*cos(phi)))).^2) + dist.^2)))*Elat))./(sqrt(a*(sqrt((b.^2)+(delta.^2)+2*delta*b*cos(phi))))));
        
        %M = integral(fun,2,3);
        
    end 
end 

function elleout = myellipe(M)
    [~,E] = ellipke(M);
    elleout = E;
end

function ellkout = myellipk(M)
    [K,~] = ellipke(M);
    ellkout = K;
end

