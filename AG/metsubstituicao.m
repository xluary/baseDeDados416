function [POP,VPL] = metsubstituicao(POP, POPnovo,VPL,VPLnovo,metSUB)
tamPOP=size(POP,1);
POPe=[];
VPLe=[];
% Nelite=5;
Nelite=10;
    switch metSUB
        case 1
            NS=10;
            [POP,VPL] = substituicaosimples (POP, POPnovo, VPL, VPLnovo,NS);
        case 2
            [POP,VPL,resto] = substituicaunicos (POP, POPnovo,VPL,VPLnovo);
            if resto>0
            tamresto=tamPOP-resto;
            [POPe,VPLe] = elitismo(POP, POPnovo, VPL, VPLnovo, tamresto);
            end
        case 3 
            Ntorneio=2;
            tamTorneio=tamPOP-Nelite;
            [POPe,VPLe] = elitismo(POP, POPnovo, VPL, VPLnovo,Nelite);
            [POP,VPL] = torneio(POP, POPnovo, VPL, VPLnovo, Ntorneio,tamTorneio);
        case 4
            Nelite=tamPOP;
            [POP,VPL] = elitismo(POP, POPnovo, VPL, VPLnovo,Nelite);
        case 5            
            tamRoleta=tamPOP-Nelite;
            [POPe,VPLe] = elitismo(POP, POPnovo, VPL, VPLnovo,Nelite);
            [POP,VPL] = roleta(POP, POPnovo, VPL, VPLnovo,tamRoleta);
        case 6 
            tamresto=tamPOP-Nelite;
            [POPe,VPLe] = elitismo(POP, POPnovo, VPL, VPLnovo,Nelite);
            POPn=[];
            VPLn=[];
            [POP,VPL]=elitismo(POPn, POPnovo, VPLn, VPLnovo, tamresto);
    end
    POP=[POP;POPe];
    VPL=[VPL;VPLe];
end
function [POP,VPL] = substituicaosimples (POP, POPnovo, VPL, VPLnovo,NS)
    [~,ind]= sort(VPL); %sort ordena o fitnes e me devolve o indice de cada um
    ind=ind(NS+1:end); %remode os  primeiros da lista ordenada de indices (piores)       
    [~,indnovo]=sort(VPLnovo,'descend'); % ordena o fitnenovo s e me devolve o indice de cada um        
    indnovo=indnovo(1:NS);  % dois primeiros da lista ordenada de indices (melhores)
    POP=[POP(ind,:); POPnovo(indnovo,:)]; %junta a população   
    VPL=[VPL(ind,:); VPLnovo(indnovo,:)]; %junta o fitness
end
function [POP,VPL,resto] = substituicaunicos (POP, POPnovo,VPL,VPLnovo)
    numFields = 120;
    numPrescriptions = 81;
    [tampop,~]=size(POP);
    pnovo=[POP; POPnovo];
    vplnovo=[VPL; VPLnovo];
    [VPLunico,ind]=unique(vplnovo,'rows');
    [l,~]=size(VPLunico);
    resto=tampop-l; 
    unicos=pnovo(ind,:);
    [~,indnovo]=sort(VPLunico,'descend'); % ordena o fitnenovo s e me devolve o indice de cada um        
    indnovo=indnovo(1:tampop);  % dois primeiros da lista ordenada de indices (melhores)
    POP=unicos(indnovo,:);
    VPL=VPLunico(indnovo,:);
end
function [POP,VPL] = elitismo(POP, POPnovo, VPL, VPLnovo,Nelite) 
    POPn=[POP;POPnovo];
    FXn=[VPL;VPLnovo];
    [~,ind]=sort(FXn,'descend');
    ind=ind(1:Nelite);
    POP=POPn(ind,:);
    VPL=FXn(ind,:);
end
function[POP,VPL] = torneio(POP, POPnovo, VPL, VPLnovo,Ntorneio,tamTorneio)

 POPn=[POP;POPnovo];
 FXn=[VPL;VPLnovo];
 
 tamPOPn=size(POPn,1);
 
 for i=1:tamTorneio
 selecionados=randperm(tamPOPn,Ntorneio); 
 [~,p]=max(FXn(selecionados));
 vencedores(i,:)=selecionados(p);
 end
 
 POP=POPn(vencedores,:);
 VPL=FXn(vencedores,:);
end

function [POP,VPL] = roleta(POP, POPnovo, VPL, VPLnovo,tamRoleta)
 POPn=[POP;POPnovo];
 FXn=[VPL;VPLnovo];
 
[~,ordvpl]=sort(FXn);
min=FXn(ordvpl(1));
max=FXn(ordvpl(end));
delta=max-min;
if delta==0 || min>=0
    VPLn=FXn;
else
    VPLn=FXn+abs(min);
end
totalFitness = sum(VPLn); %soma todos os fitness
valorProb = VPLn/totalFitness; %pega as probabilidadesde cada um ser escolhido

 tamanho = length(valorProb); %10 tamanho da populacao

    for i = 2:tamanho 
        valorProb(i) = valorProb(i) + valorProb(i-1); %descobre o valor da probabilidade final para definir o numero entre 0 e 1
    end 
    
    for i = 1:tamRoleta %10
            sorteado = rand(1); %gera um número aleatório entre 0 e 1
            for j = 1:tamanho 
                if sorteado <= valorProb(j) %se o numero selecionado for menor que a probabilidade do numero avaliado
                   POPs(i,:) = POPn(j,:); %adiciona selecionado na populacao
                   VPLs(i,:)= FXn(j,:);
                    break;
                end    
            end
    end 
    POP=POPs;
    VPL=VPLs;
end