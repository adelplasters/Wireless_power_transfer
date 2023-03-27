%one turn circular conductive loop 

classdef One_turn_circular_loop

    properties

       
       
        dout; %diameter of the loop
        w; %diameter of wire
        L; 
        Cp; %parasitic capacitance  
        ESR; % total resistance 
        lc; %length of wire
        rhoc; %resistività del materiale
        f; %operating frequency
        lg; %gap lenght between conductors
        n; %numero di avvolgimenti
        s; %spacing between turns; 
        Rdc;
        Q; 
        Rskin;
        R1;
        l;
        f0; %resonant frequency


    end


     methods 
         function [coilobj] = One_turn_circular_loop(dout,w,n,s,din)

             coilobj.dout = dout; 
             coilobj.w = w; 
             coilobj.n = n;
             coilobj.s = s; 
             f = 13.56e6; 
             
             
             l = pi*dout*n;
             mu0 = (4*pi)*1e-7; %permeabilità dello spazio
             mur = 1; %permeabilità del conduttore, circa 1 per il rame in una PCB
             mu = mu0; %permeability with no air gap, non ho trovato un valore 
             eps0 = 8.9*1e-12; 
             epsr = 0.999; 
             omega = 2*pi*f; 
             %l = pi*dout*n;
             davg = 0.5*(dout + din); 
             Ac = pi*((dout/2) - (din/2))^2; %cross sectional area of the conductor nel caso di un cerchio 


             %nuovo modo di implementare la L 
             zk = l/(pi*dout/2);
             k0 = 2.30038;
             k1 = 3.437;
             %k2 = 1.76356;
             w1 = -0.47;
             w2 = 0.755;
             nu = 1.44;

             factor1 = log(1 + (1/zk));
             factor2 = k0 + k1*(l/dout)^2;
             factor3 = w1/(((abs(w2)^2) + dout/l)^nu); 

             K = zk*(factor1 + 1/(factor2 + factor3));
             
             coilobj.L = 0.5*mu0*mur*dout*log(dout/w);
            


             %calcolo della Rdc 
                
             rhoc = 1.72*1e-8; %resistivity of conductive material
             n = 1; %total number of turns
             delta = sqrt(rhoc/(pi*mu*f));

             lc = pi*davg*n; 

             %nel caso di incremento della operating frequency la formula
             %da usare diventa:
             coilobj.Rdc = (rhoc/(pi*((dout)^2)))*n.*(2*pi*w^2);

             Rwwc = coilobj.Rdc*rhoc/(delta*pi*(dout - delta));
  

             %b = dout*n; %sarebbe la distanza tra centri di due avvolgimenti

             %proximity effect 

             
             %Rprox al momento non la implemento in quanto non è immediata 






             coilobj.ESR = Rwwc ; 
            


             %parasitic capacitance 
             i = 38e-6; %thickness of the insulation layer 
             tetae = pi/2; %effective angle between turn i and turn j
             

             fun = @(teta) pi*dout*(w/2)./(i + (w/2).*epsr*(1 - cos(teta)) + 0.5*epsr*s); 
             factor1 = integral(fun,0,tetae/2);
             Cturn = eps0*epsr*factor1; 

             coilobj.Cp = 2*n*Cturn; 

             %calcolo del quality factor, al momento calcolato con Rwwc 

             coilobj.Q = omega*coilobj.L./coilobj.ESR;
             
             %resonant frequency
             coilobj.f0 = 1/(2*pi*sqrt(coilobj.L*coilobj.Cp));
   

   %   ********************  
   %   CASO PROVENIENTE DALL'ARTICOLO DI ANTONIO
   %   % coilobj.L = (mu0*pi*((dout/2)^2)*(n^2)*K)/l;
   %   coilobj.Rdc = rhoc*lc/Ac;
   %   coilobj.Rskin = lc*rhoc/(pi*dout*delta);

   %   
   %   %Rprox = l*R1/(pi*r*sqrt(1 - (r/b)^2));
   %   ********************
             
           
     


         end 
     end 
end 
            