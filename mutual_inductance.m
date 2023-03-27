%mutual inductance and coupling coefficient function for a 2-coil system. 

function [M,k] = mutual_inductance(Rx,Tx,misalignment)
    
    a = 22e-2; %Tx radius
    b = 0.7e-2; %Rx radius
    m1 = 158; %turns of Tx
    m2 = 3; %turns of Rx
    mu0 = (4*pi)*1e-7;
    dist = linspace(5e-2,20e-2,100); 
    delta = linspace(0,18e-2,100); %centre - centre distance
    N = zeros(100);
    K = zeros(100);
    E = zeros(100);
    G = zeros(100);
    M = zeros(100,100);
    alfa = 0;
    k = zeros(100,100);
    

    switch misalignment
    %coaxial case, no misalignment

        case 'coaxial'
             for i=1:100
                 
                   N(i) =(4*a*b/(((a+b)^2) + dist(i)^2))^(1/2);
                   [K(i),E(i)] = ellipke(N(i));
                   G(i) = ((2/N(i)) - N(i))*K(i) - (2/N(i))*E(i);
                   M(i) = (mu0*(sqrt(a*b))*G(i))/(m1*m2);
                   k(i) = M(i)/sqrt(Tx.L*Rx.L);
             end 
               
             %X = sum(M); 
             %k = X/sqrt(Tx.L * Rx.L);

             

    %lateral misalignment 
        case 'lateral'
               for i=1:100
                   for j=1:100
                        beta = @(phi) atan(delta(i).*sin(phi)./(b + delta(i).*cos(phi)));
                        blat = @(phi) sqrt((b^2)+(delta(i).^2)+2*delta(i).*b*cos(phi));
                        Nlat = @(phi) sqrt(4*a*blat(phi))/(((a + blat(phi))^2) + dist^2);
        %[Klat,~] = @(phi) ellipke(Nlat(phi));
        %Glat = @(phi) ((2/Nlat(phi)) - Nlat(phi))*Klat - (2/Nlat(phi))*Elat;
                        Glat = @(x)(2./(x) - x).*myellipk(x.^2) - (2./(x)).*myellipe(x.^2);

                        r12 = @(phi,theta) sqrt((a^2) + (b^2) + (dist(j)^2) + delta(i)^2 - 2*delta(i)*a*cos(theta) + 2*delta(i)*b*cos(phi) - 2*a*b*cos(phi - theta));

                        factor1 = mu0*a*b/(4*pi);
                %fun = @(x) (cos(beta(x)).*Glat(x)./(sqrt(a.*blat(x))));
                        intfun = @(phi,theta) ((cos(phi - theta))./r12(phi,theta));
                        M(i,j) = factor1*integral2(intfun,0,2*pi,0,2*pi,'RelTol',1e-9,'AbsTol',1e-14,'method','iterated');
                %M = factor1*integral(fun,0,2*pi);
                        k(i,j) = M(i,j)./sqrt(Tx.L*Rx.L);
                    end 
               end
        %coupling coefficient:

        

        %angular misalignment

        case 'angular'
            for i=1:100
            gamma = @(phi) atan(sin(phi)/(cos(phi)*cos(alfa)));

            %factors for Nang
            factor1 = @(phi) 4*a*b*cos(phi)/cos(gamma);
            factor2 = @(phi) 2*a*b*cos(phi)*cos(alfa)/cos(gamma);
            factor3 = @(phi) 2*b*dist(i)*cos(phi)*sin(alfa);

            Nang = @(phi) sqrt(factor1/((a^2)+(b^2)+(dist(i)^2) - factor3 + factor2));
            Gang = @(x) ((2/(x)) - x)*myellipk(x.^2) - (2/x)*myellipe(x.^2);

            factor4 = (mu0*sqrt(a*b))/pi*sqrt(cos(alfa));

            fun = @(x,phi) ((cos(gamma(x))/cos(phi))^(3/2))*Gang(x);

            M = factor4*integral(fun,0,pi);
            end 

            %coupling coefficient:
            k = M./sqrt(Tx.L*Rx.L);



    end 
       
    
    
        %fun = @(phi)(factor1*(cos(atan(delta*sin(phi)./(b + delta*cos(phi))))*(((2./(sqrt(4*a*(sqrt((b.^2)+(delta.^2)+2*delta*b*cos(phi))))./(((a + (sqrt((b.^2)+(delta.^2)+2*delta*b*cos(phi)))).^2) + dist.^2))) - (sqrt(4*a*(sqrt((b.^2)+(delta.^2)+2*delta*b*cos(phi))))./(((a + (sqrt((b.^2)+(delta.^2)+2*delta*b*cos(phi)))).^2) + dist.^2)))*Klat - (2./(sqrt(4*a*(sqrt((b.^2)+(delta.^2)+2*delta*b*cos(phi))))./(((a + (sqrt((b.^2)+(delta.^2)+2*delta*b*cos(phi)))).^2) + dist.^2)))*Elat))./(sqrt(a*(sqrt((b.^2)+(delta.^2)+2*delta*b*cos(phi))))));
        
        %M = integral(fun,2,3);

   
        
end 

 
function elleout = myellipe(M)
    [~,E] = ellipke(M);
    elleout = E;
end

function ellkout = myellipk(M)
    [K,~] = ellipke(M);
    ellkout = K;
end

