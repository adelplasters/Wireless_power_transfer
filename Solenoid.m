%This class defines a solenoidal type of coil. 

classdef Solenoid

    properties
        l; %cross-sectional area's width
        ESR; %total resistive contribution
        Q; %quality factor
        L; %self-inductance
        n; %turns number
        ltot; %total length of solenoid
        Rdc; %series resistance
        Rskin; %skin effect resistance
        D; %wire diameter, imposed at 0.6 mm
        Cself; %self capacitance 
        f0; %resonant frequency
        p; %pitch size
        f; %operating frequency
        Rprox;

   

    end 

    methods 
        function [coilobj] =Solenoid(Is,f,l,n,ltot,D)

            coilobj.l = l; 
            coilobj.ltot = ltot;
            coilobj.p = 0.0007;
            coilobj.D = D;
            coilobj.f = f;
            
            mu0 = (4*pi)*1e-7; %magnetic permeability of space
            rhoc = 1.67e-8; %ohm*m --> copper resistivity
            omega = 2*pi*f;
            mu = 1.26e-6; %overall permeability (air*copper)
            sigma = 58.5e6; %Conductivity of Cu = 58.5e6 S/m

      %Computation of self-inductance:

            coilobj.L = (mu0*(n^2)*pi*(l^2))/ltot;


      %There are different paths to compute resistive contributions.

            coilobj.Rdc = (rhoc*ltot)/(pi*l^2);
            delta = sqrt(2*rhoc/(omega*mu));
            coilobj.Rskin = ltot*rhoc/(pi*delta*D);

          
            

      %First, we compute here the proximity contribution:
            
            Hmpair = zeros(1,n);
            Hmasy = zeros(1,n);
            %First work out Hmasy
            for m=1:n
                if m==(n/2+0.5)
                    %Full symmetry, no fields
                    Hmasy(m)=0;
                elseif m<(n/2)
                    %'Left' block
                    for k=2*m:n
                        Hmasy(m) = Hmasy(m) + (1/(2*pi)).*((coilobj.p.*abs(m-k))./(coilobj.p.^2*abs(m-k).^2+D.^2));
                    end
                elseif (m>(n/2) && m<n)
                    %'Right' block
                    for k=1:(2*m-n-1)
                        Hmasy(m) = Hmasy(m) + (1/(2*pi)).*((coilobj.p.*abs(m-k))./(coilobj.p.^2*abs(m-k).^2+D.^2));
                    end
                elseif m==n
                    %Final case
                    for k=1:(n-1)
                        Hmasy(m) = Hmasy(m) + (1/(2*pi)).*((coilobj.p.*abs(m-k))./(coilobj.p.^2.*abs(m-k).^2+D.^2));
                    end
                end
            end

            %Next work out Hmpair in a similar way
            for m=1:n
                if m==1
                    Hmpair(m) = 0;
                elseif m==n
                    Hmpair(m) = 0;
                elseif m<=(n/2)
                    for i=1:m-1
                        Hmpair(m) = Hmpair(m) + (1/(2*pi))*((2*D)./(coilobj.p.^2*(m-i).^2-D.^2));
                    end
                elseif m>(n/2)
                    for i=(2*m-n):m-1
                        Hmpair(m) = Hmpair(m) + (1/(2*pi)).*((2.*D)./(coilobj.p.^2*(m-i).^2-D.^2));
                    end
                end
            end
            
            Hm = sum(Hmpair + Hmasy);
            %delta = 1./((pi.*f*mu0*sigma).^(1/2));
            %x = 2*D./delta;
            
            coilobj.Rprox = 2*(pi.^2)*((D/2).^2)*((D/delta) -1)*(Hm.^2)/(Is.^2);
            %KimRDC = 1./(pi.*D.^2.*sigma); %RDC per unit length
            %KimRloss = (KimRDC./(16*x)).*((2.*x+1).^2 + 2 + ((8*pi.^2*delta.^2.*x.^3.*(x-1))./(n)).*sum(Hm.^2));

            %KimRskin = KimRDC.*(1/4 + r0./(2*delta) + (3/32)*(delta./r0));
            %Rsskin = KimRskin.*wirelen;
           % wirelen = 2*pi*l.*n;

            %total resistive contribution:
            %coilobj.ESR = KimRloss.*wirelen;
            coilobj.ESR = coilobj.Rdc*coilobj.Rskin + coilobj.Rdc*coilobj.Rprox;



            %self capacitance:
            coilobj.Cself = 1.86*2*coilobj.l; 
            
            %self resonance frequency:
            coilobj.f0 = 1/(2*pi*sqrt(coilobj.L*coilobj.Cself));
            
            %quality factor:
            coilobj.Q = omega*coilobj.L./coilobj.ESR;


        end 
    end 
end 