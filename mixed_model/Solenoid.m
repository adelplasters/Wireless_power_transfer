classdef Solenoid

    properties
        l; %lato della cross sectional area
        Cp;
        ESR;
        Q; 
        L; 
        n; %turns number
        ltot; %total length of solenoid
        Rdc; %series resistance

   

    end 

    methods 
        function [coilobj] =Solenoid(l,n,ltot)

            mu0 = (4*pi)*1e-7;
            rhoc = 1.72*e-8; %ohm*m --> copper resistivity

            coilobj.l = l; 
            coilobj.ltot = ltot;


            coilobj.L = (mu0*(n^2)*(l^2))/ltot;
            coilobj.Rdc = (rhoc*ltot)/(l^2);

            




        end 
    end 
end 