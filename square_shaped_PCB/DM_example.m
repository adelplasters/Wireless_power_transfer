%definisco dei parametri 


%Tx e Rx
[coilTx, omega] = Square_Shaped_PCB(35e-6,35e-6,5,3e-3,1e-3,13.56e6,5e-3,40e-3,17e-9,'hexagonal'); 

[coilRx, omega] = Square_Shaped_PCB(35e-6,35e-6,5,3e-3,1e-3,13.56e6,5e-3,40e-3,17e-9,'square'); 

%mutua induttanza e coupling coefficient

[M,k] = mutua_induttanzaideal(coilTx, coilRx, 1e-2); 

%calcolo della link efficiency ovvero della PTE 
[linkeff, Pmn, Z_Rx_Txref] = Link_eff_2coils(100,'S_resonator', coilRx, coilTx,k, 'voltage_series'); 


