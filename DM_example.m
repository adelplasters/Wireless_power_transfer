
%Tx 
coilTx = Square_Shaped_PCB(35e-6,35e-6,5,3e-3,1e-3,13.56e6,5e-3,40e-3,17e-9); 

coilRx = Square_Shaped_PCB(35e-6,35e-6,5,3e-3,1e-3,13.56e6,5e-3,40e-3,17e-9); 

[M,k] = mutua_induttanzaideal(coilTx, coilRx, 1e-2); 

