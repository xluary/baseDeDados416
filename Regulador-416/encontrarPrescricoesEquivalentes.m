function solucaoFinal =  encontrarPrescricoesEquivalentes (solucao, data, hp)
    [l, c] = size(data);
    contador = 0;
    for i = 1: l
       contador = contador + 1;
       prescricao = 0;
       for j = 1: c
           baseDeDados = data(i,j).production;
           igual = zeros(1, hp);
           for k = 1: hp
               if baseDeDados(1, k) == solucao(contador, k)
                   igual(1, k) = 1;
               end
           end
           if sum(igual) == hp
               solucaoFinal(1,i) = j;
           end
       end
    end
end

