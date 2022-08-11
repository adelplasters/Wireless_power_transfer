%funzione per calcolare la link efficiency e il Pmn delivered to Rx 


function [linkeff, Pmn] = Link_eff(Rl, config_resonator, coilRx, coilTx,k, config_Txcircuit)

f = 13.56e6;
omega=2*pi*f;

switch config_resonator 

    case 'S_resonator'

        Zmn = Rl - (1/(omega*coilRx.CP))*1i; 

        Ql = (omega*coilRx.L)./real(Zmn); 

    case 'P_resonator'

        Zmn = 1/(Rl*(omega*coilRx.CP)^2) - (1/(omega*coilRx.CP))*1i;

        Ql = omega*coilRx.L./real(Zmn); 

end 

QRxl = coilRx.Q*Ql./(coilRx.Q + Ql); 

linkeffRx = QRxl./Ql; 
linkeffTx1= (k^2)*coilTx.Q*QRxl; 
linkeffTx2= (k^2)*coilTx.Q*QRxl + 1; 

linkeff = linkeffRx*linkeffTx1./linkeffTx2;


switch config_Txcircuit
    case 'voltage_series'
        Vs = 5;
        Pmn = (Vs^2)*QRxl*linkeffTx1/(2*coilTx.ESR*Ql*(linkeffTx2)^2);
    case 'voltage_parallel'
        Vs = 5;
        Pmn = ((Vs^2)*coilTx.ESR*QRxl*linkeffTx1)/((2*(omega*coilTx.L)^2)*Ql);
    case 'current_series'
        Is = 2e-3;
         Pmn = ((Is^2)*coilTx.ESR*QRxl*linkeffTx1)/(2*Ql);
    case 'current_parallel'
        Is = 2e-3;
        Pmn = (((Is^2)*(omega*coilTx.L)^2)*QRxl*linkeffTx1)/(2*coilTx.ESR*Ql*(linkeffTx2)^2);
end 
end 

