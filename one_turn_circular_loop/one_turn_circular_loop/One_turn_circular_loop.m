%one turn circular conductive loop 

classdef One_turn_circular_loop

    properties

       
       
        dout; %diameter of the loop
        w; %diameter of wire
        L; 
        Cp; %parasitic capacitance  
        ESR; % total resistance 
        l; %length of wire
        rhoc; %resistività del materiale
        f; %operating frequency
        lg; %gap lenght between conductors
        n; %numero di avvolgimenti
        s; %spacing between turns; 
        Rdc;
        Q; 
        Rskin;
        R1;


    end


     methods 
         function [coilobj] = One_turn_circular_loop(dout,w,n,s)

             coilobj.dout = dout; 
             coilobj.w = w; 
             coilobj.n = n;
             coilobj.s = s; 
             f = 13.56e6; 
             

             mu0 = (4*pi)*1e-7; %permeabilità dello spazio
             mur = 1; %permeabilità del conduttore, circa 1 per il rame in una PCB
             mu = mu0; %permeability with no air gap, non ho trovato un valore 
             eps0 = 8.9*1e-12; 
             epsr = 0.999; 
             omega = 2*pi*f; 

             coilobj.L = 0.5*mu0*mur*dout*log(dout/w); 


             %calcolo della Rdc 
                
             rhoc = 1.72*1e-8; %resistivity of conductive material
             n = 1; %total number of turns
             delta = sqrt(rhoc/(pi*mu*f));

             coilobj.Rdc = rhoc*n.*(2*pi*w^2)/(pi*((dout)^2));



             %nel caso di incremento della operating frequency la formula
             %da usare diventa:

             
             Rwwc = coilobj.Rdc*rhoc/(delta*pi*(dout - delta));

             %provo a implementare lo skin effect
             %--> sarebbe da cambiare formula nel caso si usasse un altro
             %tipo di cavo

             %surface resistivity
            
             l = pi*dout*n;
             coilobj.Rskin = l*rhoc/(pi*dout*delta);

             %b = dout*n; %sarebbe la distanza tra centri di due avvolgimenti

             %proximity effect 

             
             %Rprox = l*R1/(pi*r*sqrt(1 - (r/b)^2));






             coilobj.ESR = Rwwc + coilobj.Rskin; 
            


             %parasitic capacitance 
             i = 38e-6; %thickness of the insulation layer 
             tetae = pi/2; %effective angle between turn i and turn j
             

             fun = @(teta) pi*dout*(w/2)./(i + (w/2).*epsr*(1 - cos(teta)) + 0.5*epsr*s); 
             factor1 = integral(fun,0,tetae/2);
             Cturn = eps0*epsr*factor1; 

             coilobj.Cp = 2*n*Cturn; 

             %calcolo del quality factor, al momento calcolato con Rwwc 

             coilobj.Q = omega*coilobj.L./coilobj.ESR;
   

           
             
           
     


         end 
     end 
end 
            