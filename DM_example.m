%esempio di utilizzo 

%d23 = 12 cm 
%d34 = 0.9 cm
%D03 = 4 cm 

[coil1] = One_turn_circular_loop(16.8e-2,150e-6,1,150e-6); %D01,w1,n1,s1
[coil2] = One_turn_circular_loop(4e-2,150e-6,1,150e-6); 
[coil3] = One_turn_circular_loop(14e-3,150e-6,1,150e-6); 


[M12, M23, M13, Lself, k12, k23, k13, Q1, Q2, Q3, Q3L, QL] = inductance(coil1, coil2, coil3, 12e-2, 0.9e-2, 18e-2);

[link_eff, P13] = Link_eff(coil1, coil2, coil3, k12, k23, k13, Q1, Q2, Q3, Q3L, QL);


