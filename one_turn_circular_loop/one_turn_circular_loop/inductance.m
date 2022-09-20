%script per calcolare la mutua induttanza tra due parallel single-turn circular
%coils con raggi r1 e r2, la self induttanza, il coefficiente di
%accoppiamento 


function [MTxA, MARx, MTxRx, Lself, kTxA, kARx, kTxRx, QTx, QA, QRx, QRxL, QL] = inductance(coilTx, coilA, coilRx, dTxA, dARx, dTxRx)

    mu = (4*pi)*1e-7;
    f0 = 13.56*1e6; 
    omega0 = 2*pi*f0; 


    rTx = coilTx.w/2; 
    rA = coilA.w/2;
    rRx = coilRx.w/2; 
    alfaTx = sqrt(rTx*rA/((rTx + rA)^2) + dTxA^2);
    alfaA = sqrt(rA*rRx/((rA + rRx)^2) + dARx^2);
    alfaRx = sqrt(rTx*rRx/((rTx + rRx)^2) + dTxRx^2);

    [KTx,ETx] = ellipke(alfaTx);
    [KA,EA] = ellipke(alfaA); 
    [KRx,ERx] = ellipke(alfaRx); 

    MTxA = 2*mu*sqrt(rTx*rA)*((1 - (alfaTx^2)/2)*KTx - ETx)/alfaTx; 
    MARx = 2*mu*sqrt(rA*rRx)*((1 - (alfaA^2)/2)*KA - EA)/alfaA; 
    MTxRx = 2*mu*sqrt(rTx*rRx)*((1 - (alfaRx^2)/2)*KRx - ERx)/alfaRx; 
    


    kTxA = MTxA/sqrt(coilTx.L*coilA.L); 
    kARx = MARx/sqrt(coilA.L*coilRx.L);
    kTxRx = MTxRx/sqrt(coilTx.L*coilRx.L);



    %self inductance 

    Lself = MTxA + MARx + MTxRx + coilTx.L + coilA.L + coilRx.L; 

    %la R2 dovrebbe contenere anche la Rs!!!!

    %quality factors, al momento calcolata con Rwwc

    QTx = coilTx.Q;
    QA = coilA.Q;
    QRx = coilRx.Q;

    Rload = 200; %deve essere tra 10 Ohm e 10k
    QL = Rload/(omega0*coilRx.L); %è il Qload
    QRxL = QRx*QL/(QRx + QL);
