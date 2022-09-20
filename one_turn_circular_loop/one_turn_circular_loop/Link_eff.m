%funzione per calcolare la link efficiency e il Pmn delivered to Rx 


function [link_eff_3coil, PTxRx] = Link_eff(coilTx, kTxA, kARx, kTxRx, QTx, QA, QRx, QRxL, QL, config_Txcircuit)

   Vs = 1;
   Is = 2;


    factor1 = (kTxA^2)*QTx*QA;
    factor2 = (kARx^2)*QA*QRxL; 
    factor3 = (kTxRx^2)*QTx*QRxL; %qua non sono sicura del valore di Q3L perchè sull'articlo è Q4L;
    A = 1 + (kTxA^2)*QTx*QA + (kARx^2)*QA*QRxL + (kTxRx^2)*QTx*QRxL; 
    B = 2*QTx*QA*QRxL*kTxA*kTxRx*kARx; 
    teta = atan(B/A);

    link_eff_3coil = ((factor1*factor2 + factor3)*QRxL)/(cos(teta)*(1 + factor2)*sqrt(A^2 + B^2)*QL); 

    switch config_Txcircuit

        case 'voltage_series'

          PTxRx = (Vs^2)*(factor1*factor2 + factor3)*QRxL/(2*coilTx.Rdc*(A^2 + B^2)*QL); 

        case 'current_series'

            PTxRx = (Is^2)*coilTx.Rwwc*QRxL*((kARx^2)*QA*QRxL)*((kTxA^2)*QTx*QA)/(2*QL*((kARx^2)*QA*QRxL + 1)^2);

    end 
   
