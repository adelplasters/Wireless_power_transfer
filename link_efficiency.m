%link efficiency calculation 

function [link_eff] = link_efficiency(k,Tx,Rx,caso)

        link_eff = zeros(100);

        switch caso
            case 'coaxial'

            for i=1:100
                link_eff(i) = (k(i)^2)*Tx.Q*Rx.Q/((1 + sqrt(1 + (k(i)^2)*Tx.Q*Rx.Q)))^2;
            end 

            case 'lateral'
                 link_eff = (k.^2)*Tx.Q*Rx.Q./((1 + sqrt(1 + (k.^2)*Tx.Q*Rx.Q))).^2;
        end 



end 