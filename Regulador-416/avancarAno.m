function talhoes = avancarAno(talhoes)
    [l,~] = size(talhoes);

    for i = 1: l
        idadeTalhao = talhoes(i, 2);
        talhoes(i,2) = idadeTalhao + 1;
    end
end

