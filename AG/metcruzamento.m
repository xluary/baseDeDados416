function filhos=metcruzamento(pais,probCRUZ,metCRUZ)
    
    switch metCRUZ
        case 1
            filhos = Cruzamento1p(pais,probCRUZ);
        case 2
            filhos = Cruzamento2p(pais,probCRUZ);
        case 3
            filhos = Uniforme(pais,probCRUZ);
    end
end

function filhos = Cruzamento1p(pais,probCRUZ)
filhos = zeros(size(pais));
[tamanho,genes] = size(pais); 
[~,tamanhoprob]= size(pais);

for i = 1:2:tamanho
    
    if rand(1) <= probCRUZ %Verifica se vai cruzar se for menor que 0.8 
            pontoCorte = ceil(tamanhoprob*rand(1));
            %Gera os filhos     
            filhos(i,:) = [pais(i,1:pontoCorte) pais(i+1,pontoCorte+1:genes)];
            filhos(i+1,:) = [pais(i+1,1:pontoCorte) pais(i,pontoCorte+1:genes)];
            
        else 
                filhos(i,:) = pais(i,:);
                filhos(i+1,:) = pais(i+1,:);
%           if tamanho-1 == i && mod(tamanho,2) == 1 %Passa pai para proxima geracao, caso nao tenha par
%              filhos(i+2,:) = pais(i+2,:);
             
             
        end
    end
end    
function filhos = Cruzamento2p(pais,probCRUZ)
filhos = zeros(size(pais));
[tamanho,genes] = size(pais); 
[~,tamanhoprob]= size(pais);

for i = 1:2:tamanho
    
    if rand(1) <= probCRUZ %Verifica se vai cruzar se for menor que 0.8 
            pontosCortes = randperm(tamanhoprob,2);
            if pontosCortes(1)>pontosCortes(2)
                pontoCorte1=pontosCortes(2);
                pontoCorte2=pontosCortes(1);
            else
                pontoCorte1=pontosCortes(1);
                pontoCorte2=pontosCortes(2);
            end
            %Gera os filhos     
            filhos(i,:) = [pais(i,1:pontoCorte1) pais(i+1,pontoCorte1+1:pontoCorte2) pais(i,pontoCorte2+1:genes)];
            filhos(i+1,:) = [pais(i+1,1:pontoCorte1) pais(i,pontoCorte1+1:pontoCorte2) pais(i+1,pontoCorte2+1:genes)];
            
        else 
                filhos(i,:) = pais(i,:);
                filhos(i+1,:) = pais(i+1,:);
%           if tamanho-1 == i && mod(tamanho,2) == 1 %Passa pai para proxima geracao, caso nao tenha par
%              filhos(i+2,:) = pais(i+2,:);
             
             
        end
    end
end 
function filhos = Uniforme(pais,probCRUZ)
filhos = zeros(size(pais));
[tamanho,genes] = size(pais); 

    for i = 1:2:tamanho
        for j=1:genes
            if rand(1) <= probCRUZ %Verifica se vai cruzar se for menor que 0.8 
              filhos(i,j)=pais(i,j);
              filhos(i+1,j)=pais(i+1,j);
            else 
              filhos(i,j)=pais(i+1,j);  
              filhos(i+1,j)=pais(i,j);
            end
        end
    end
end  