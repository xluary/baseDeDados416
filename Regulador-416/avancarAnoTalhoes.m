function objetosTalhoes = avancarAnoTalhoes(objetosTalhoes)
    [~, c] = size(objetosTalhoes);
    for i =1: c
       objetosTalhoes(1,i) = avancarAno(objetosTalhoes(1,i)); 
    end
end