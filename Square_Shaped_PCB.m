classdef Square_Shaped_PCB

    properties

        n; %number of turns
        din; %internal diameter
        dout; %external parameter
        S; 
        W; %larghezza traccia 
        L; 
        CP; 
        ESR; 
        l; %length of wire
        Ts; %spessore del substrato 
        T; %spessore traccia 
        rho; %resistività del materiale
        f;
        lg; %gap lenght between conductors 
         % aggiungi quelle di solwirecoil

    end

    methods 
        function coilobj = Square_Shaped_PCB(Ts,n,S,W,f,CP,sourceres,rho)

        coilobj.n = n; %n in input = alla n definita sopra 
        coilobj.S = S;
        coilobj.W = W;
        coilobj.Ts = Ts;
        coilobj.l = 4.*n.*dout - 4.*n.*W - ((2*n + 1)^2)*(S + W);

        mu0 = (4*pi)*1e-7;
        c1 = 1.27;
        c2 = 2.07;
        c3 = 0.18;
        c4 = 0.13; 

        davg = 1/2*(dout + din); 
        phi = (dout - din)/(dout + din); 

        factor1 = (c1*mu0*(n^2)*davg)/2; 
        factor2 = log(c2/phi); 

        coilobj.L = factor1*(factor2 + c3*phi + c4*(phi^2)); 
     
            


        %calcolo della ESR

        Rdc = rho*l/(W.*T);
        omega = 2*pi*f;

        delta = sqrt(2*rho/(mu0*omega)); 

        factorr2 = T/(delta*(1 - exp(-T/delta)));
        factorr3 = 1/(1 + T/W); 

        Rskin = Rdc*factorr2*factorr3; 

        omegac = (3.1/mu0)*((S + W)/W^2)*rho/T; 

        Rprox = (Rdc/10)*((omega/omegac)^2); 

        coilobj.ESR = Rskin + Rdc*Rprox; 



        %calcolo della capacità parasitica 
        
        %da determinare empiricamente 
        alfa = 0.9; 
        beta = 0.1; 

        epsilonrt = 1; %dielectric constant of the surrouding
        epsilonrs = 4.4; %dielectric constant of the substrate 
        epsilon0 = 8.854e-12; 

        %versione semplice della capacità

        %coilobj.lg = 4*(dout - W.*n)*(n-1) - 4*S.*n*(n+1); 

        %coilobj.CP = (alfa*epsilonrt + beta*epsilonrs)*epsilon0*T*lg/S;

        
        %versione complessa 
        k0 = S/(S + 2*W); 
        k01 = sqrt(1 - k0^2);
        
        factork1 = tanh(pi*S/(4*Ts));
        factork2 = tanh(pi*(S+2*W)/(4*Ts)); 

        k1 = factork1/factork2; 

        k11 = sqrt(1-k1^2); 

        [Kk11,~] = ellipke(k11); 
        [Kk0,~] = ellipke(k0); 
        [Kk01,~] = ellipke(k01); 
        [Kk1,~] = ellipke(k1); 
        
        epsiloneff = 1 + (epsilonrs - 1)*1/2*Kk11*Kk0/(Kk1*Kk01);

        coilobj.CP = epsilon0*epsiloneff*Kko1*l/Kk0;

        fself = 1/(2*pi*sqrt(L*CP)); 

        end 
    end 
end 

       




        


