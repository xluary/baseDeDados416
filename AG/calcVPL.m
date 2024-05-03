function [VPL,P,ProdMelhor] = calcVPL(POP,data,VPLmin,VPLmax,penalty,hP)
    global contador;
    numPOP = size(POP,1);
    contador=contador+numPOP;
    numFields = size(data,1);
    
    
    VPL = zeros(numPOP,1);
    P = zeros(numPOP,hP);   
    VPLmelhor=-17*(10^200);
    for i = 1:numPOP        
        production = zeros(numFields,hP);        
        for j = 1:numFields
            production(j,:) = data(j,POP(i,j)).production;
            VPL(i) = VPL(i) + data(j,POP(i,j)).VPL;
        end
      
        P(i,:) = sum(production);
         excesso=0;
        for h=1:hP
            if P(i,h)>VPLmax
                excesso=excesso+(P(i,h)-VPLmax);
            elseif P(i,h)<VPLmin
                excesso=excesso+(VPLmin-P(i,h));
            end
        end
        VPL(i)=VPL(i)-penalty*excesso;
        
        if VPL (i) > VPLmelhor
            ProdMelhor= production;
            VPLmelhor= VPL (i);
        end
    end
end