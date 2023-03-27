%link efficiency calculation 

function [link_eff,Pmn] = link_efficiency(Is,k,Tx,Rx,caso,QL)

        QRxL = Rx.Q*QL/(QL + Rx.Q);
       
       

        switch caso
            case 'coaxial'
                 Pmn = zeros(6); 
                 link_eff = zeros(6);
                 

                 for i=1:6
                    
                   link_eff(i)=QRxL*(k(i).^2).*Tx.Q.*QRxL./(QL*((k(i).^2).*Tx.Q.*QRxL + 1));
                   Pmn(i) = (Is.^2).*Tx.ESR.*QRxL.*(k(i).^2)*Tx.Q.*QRxL/(2.*QL);
                 end
                 plot(link_eff,'b');

             
            case 'lateral'
                link_eff = zeros(100,5);
                Pmn = zeros(100,5); 
                delta = linspace(0,18e-2,100);
       
                for j=1:5
                    for i=1:100
                     link_eff(i,j)=QRxL*(k(i,j).^2).*Tx.Q.*QRxL./(QL*((k(i,j).^2).*Tx.Q.*QRxL + 1));
                     Pmn(i,j) = (Is.^2).*Tx.ESR.*QRxL.*(k(i,j).^2)*Tx.Q.*QRxL/(2.*QL);

                    end 
                     plot(delta,link_eff);
                     xlabel('Lateral misaligment [m]');
                     ylabel('Link efficiency');
                     legend('dist=5cm','dist=6cm','dist=10cm','dist=13cm','dist=18cm','dist=20cm');
                end 

                   
                  
        end 



end 