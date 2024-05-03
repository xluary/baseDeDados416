function POPnovo=metmutacao(filhos,probMUT,metMUT)
[tamanho,genes] = size(filhos);   
    switch metMUT
        case 1
             POPnovo = Mut_swap(filhos,probMUT,tamanho,genes);
        case 2
             POPnovo = Mut_nprescricao(filhos,probMUT,tamanho);
        case 3 
             POPnovo = Mut_maisoumenos(filhos,probMUT,tamanho);
        case 4
             POPnovo = Geneagene(filhos,probMUT,tamanho, genes);
        otherwise
             POPnovo=filhos;
    end

end    
function POPnovo = Mut_swap(filhos,probMUT,tamanho,genes)
POPnovo=filhos;
cont=0;
    for i = 1:tamanho
       for y = 1:genes
           w=rand(1);
            if w <= probMUT %se for menor vai fazer a mutacao
                    r = randperm(size(filhos,2),2);
                    filhos(i,[r(1), r(2)])= filhos(i,[r(2),r(1)]); 
            end  
       end
        POPnovo(i,:)= filhos(i,:);
    end
end
function POPnovo = Mut_nprescricao(filhos,probMUT,tamanho)
    for i = 1:tamanho %50
        if rand(1) <= probMUT %se for menor vai fazer a mutaca
            novaprescricao=randperm(81,1); 
            r = randperm(size(filhos,1),1);
            filhos(i,r)=novaprescricao;
            POPnovo(i,:)= filhos(i,:);
        else
            POPnovo(i,:)= filhos(i,:);
        end    
    end
end

function POPnovo = Mut_maisoumenos(filhos,probMUT,tamanho)
    for i = 1:tamanho
        if rand(1) <= probMUT %se for menor vai fazer a mutacao
            r = randperm(size(filhos,1),1);   
            l=randperm(10,1);
            if rand>0.5
                novaprescricao=filhos(i,r)+l;  
            else
                novaprescricao=filhos(i,r)-l; 
            end 
            if novaprescricao>81
                novaprescricao=1;
            end
            if novaprescricao<1
               novaprescricao=81;
            end
            filhos(i,r)=novaprescricao;
            POPnovo(i,:)= filhos(i,:);
        else
            POPnovo(i,:)= filhos(i,:);
        end           
    end
end

function POPnovo = Geneagene(filhos,probMUT,tamanho,genes)
    for i = 1:tamanho %50
        for j=1:genes
            if rand(1) <= probMUT %se for menor vai fazer a mutaca
                novaprescricao=randperm(81,1); 
                filhos(i,j)=novaprescricao;
            end            
        end
        POPnovo(i,:)= filhos(i,:);
    end
end


