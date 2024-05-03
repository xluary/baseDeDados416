function [talhoesOrdenados, qMaisVelho] = ordenarPorIdade(talhoes)
    [l,~] = size(talhoes);
    [~, talhoesOrdenados] = sort(talhoes(:,2), 'descend');
    %ocorrencia = histcounts(talhoes(:,2)); //não exite no octave
    maisVelho = max(talhoes(:,2));
    qMaisVelho = 0;
    for i = 1:l
      if(talhoes(i,2) == maisVelho)
        qMaisVelho = qMaisVelho + 1;
      end
    end

end
