%esempio di utilizzo 



Vs = 5; 
Is = 2; 

%12e-2, 9e-2, 15e-2

[coilTx] = One_turn_circular_loop(15e-2,150e-6,1,150e-6); %D01,w1,n1,s1
[coilA] = One_turn_circular_loop(2e-2,150e-6,1,150e-6); 
[coilRx] = One_turn_circular_loop(14e-3,150e-6,1,150e-6); 

%coilTx, coilA, coilRx, dTxA, dARx, dTxRx
[MTxA, MARx, MTxRx, Lself, kTxA, kARx, kTxRx, QTx, QA, QRx, QRxL, QL] = inductance(coilTx, coilA, coilRx, 0.5, 9e-2, 0.59);

[link_eff, PTxRx] = Link_eff(coilTx, kTxRx, kARx, kTxRx, QTx, QA, QRx, QRxL, QL, 'voltage_series');


