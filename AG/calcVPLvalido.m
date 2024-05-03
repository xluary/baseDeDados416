function [VPL,P,ProdMelhor,valido,vlpvalido] = calcVPLvalido(POP,data,VPLmin,VPLmax,penalty)
    global contador;
    numPOP = size(POP,1);
    contador=contador+numPOP;
    numFields = size(data,1);
    
    VPL = zeros(numPOP,1);
    P = zeros(numPOP,16);   
    VPLmelhor=-17*(10^20);
    valido=[];
    vlpvalido=[];
    for i = 1:numPOP        
        production = zeros(numFields,16);        
        for j = 1:numFields
            production(j,:) = data(j,POP(i,j)).production;
            VPL(i) = VPL(i) + data(j,POP(i,j)).VPL;
        end
      
        P(i,:) = sum(production);
         excesso=0;
        for h=1:16
            if P(i,h)>VPLmax
                excesso=excesso+(P(i,h)-VPLmax);
            elseif P(i,h)<VPLmin
                excesso=excesso+(VPLmin-P(i,h));
            end
        end
        VPL(i)=VPL(i)-penalty*excesso;
        if excesso==0
            valido(end+1,:)=POP(i,:);
            vlpvalido(end+1,:)=VPL(i);
        end
        if VPL (i) > VPLmelhor
            ProdMelhor= production;
            VPLmelhor= VPL (i);
        end
    end
end