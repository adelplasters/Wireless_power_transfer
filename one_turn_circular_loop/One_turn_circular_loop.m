%one turn circular conductive loop 

classdef One_turn_circular_loop

    properties

       
       
        dout; %diameter of the loop
        w; %diameter of wire
        L; 
        CP; 
        ESR; 
        l; %length of wire
        rho; %resistività del materiale
        f; %operating frequency
        lg; %gap lenght between conductors 
         % aggiungi quelle di solwirecoil
         Q; %quality factor
         n; %numero di avvolgimenti

    end


     methods 
         function [coilobj] = One_turn_circular_loop(dout,w,n)

             coilobj.dout = dout; 
             coilobj.w = w; 
             coilobj.n = n;

             mu0 = (4*pi)*1e-7; %permeabilità dello spazio
             mur = 0; %permeabilità del conduttore
             mu = 0; %permeability with no air gap
             eps0 = 8.9*1e-12; 
             epsr = 0; 

             coilobj.L = 0.5*mu0*mur*dout*log(dout/w); 


             %calcolo della Rdc 
                
             rhoc = 0; %resistivity of conductive material
             n = 1; %total number of turns
             delta = sqrt(rhoc/(pi*mu*f));

             Rdc = rhoc*n.*(2*pi*w^2)/(pi*((dout)^2));

             %nel caso di incremento della operating frequency la formula
             %da usare diventa:

             
             Rwwc = Rdc*rhoc/(delta*pi*(dout - delta));


             %parasitic capacitance 
             i = 0; %thickness of the insulation layer 
             tetae = pi/2; %effective angle between turn i and turn j
             s = 0; %spacing between turns; 
     

             factor1 = pi*dout*(w/2)/(i + (w/2)*epsr*(1 - cos(teta)) + 0.5*epsr*s); 
             factor1 = int(factor1,teta,0,tetae/2);
             Cturn = eps0*epsr*factor1; 

             Cp = 2*n*Cturn; 

           
             
           
     


         end 
     end 
end 
            