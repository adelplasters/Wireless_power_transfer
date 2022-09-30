%link efficiency calculation 

function [link_eff] = link_efficiency(k,Tx,Rx)

    link_eff = (k^2)*Tx.Q*Rx.Q/((1 + sqrt(1 + (k^2)*Tx.Q*Rx.Q)))^2;

end 