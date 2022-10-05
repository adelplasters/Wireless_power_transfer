classdef Solenoid

    properties
        l; %lato della cross sectional area
        ESR;
        Q; 
        L; 
        n; %turns number
        ltot; %total length of solenoid
        Rdc; %series resistance
        Rskin;
        D; %wire diameter 0.3 mm
        Cself; %self capacitance 
        f0; %resonant frequency

   

    end 

    methods 
        function [coilobj] =Solenoid(l,n,ltot,D)

            mu0 = (4*pi)*1e-7;
            rhoc = 1.72e-8; %ohm*m --> copper resistivity
            f = 13.56e6;
            omega = 2*pi*f;
            mu = 1.26e-6; %sarebbe mu0*mur
            diam = 40e-2;
            

            coilobj.l = l; 
            coilobj.ltot = ltot;


            coilobj.L = (mu0*(n^2)*(l^2))/ltot;
            coilobj.Rdc = (rhoc*ltot)/(l^2);
            delta = sqrt(2*rhoc/(omega*mu));
            coilobj.Rskin = ltot*rhoc/(pi*delta*D);

            coilobj.ESR = coilobj.Rdc*coilobj.Rskin;

            %proximity effect is reduced by Litz wires. 

            %self capacitance
            coilobj.Cself = 1.86*diam; 

            coilobj.f0 = 1/(2*pi*sqrt(coilobj.L*coilobj.Cself));

            coilobj.Q = omega*coilobj.L/coilobj.ESR;


            




        end 
    end 
end 