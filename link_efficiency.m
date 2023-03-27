%link efficiency calculation 

function [link_eff,Pmn] = link_efficiency(Is,k,Tx,Rx,caso,QL)

        link_eff = zeros(100);
        QRxL = Rx.Q*QL/(QL + Rx.Q);

        switch caso
            case 'coaxial'

            for i=1:100
                %link_eff(i) = (k(i).^2).*Tx.Q.*Rx.Q./((1 + sqrt(1 + (k(i).^2).*Tx.Q.*Rx.Q))).^2;
                link_eff(i)=QRxL*(k(i).^2).*Tx.Q.*QRxL./(QL*((k(i).^2).*Tx.Q.*QRxL + 1));
                Pmn = (Is.^2).*Tx.ESR.*QRxL.*(k.^2)*Tx.Q.*QRxL/(2.*QL);
                
            end 

            case 'lateral'
                for i=1:100
                 link_eff(i)=QRxL*(k(i).^2).*Tx.Q.*QRxL./(QL*((k(i).^2).*Tx.Q.*QRxL + 1));
                 Pmn = (Is.^2).*Tx.ESR.*QRxL.*(k.^2)*Tx.Q.*QRxL/(2.*QL);
                end 
        end 



end 