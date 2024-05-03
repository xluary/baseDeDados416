function objetosTalhoes = gerarTalhoes(producaoPorIdade,talhoes)
[l,~] = size(talhoes);

    for i = 1: l
        objeto = talhao(i, talhoes(i, 2), talhoes(i, 3),producaoPorIdade(i,3:end));
        objetosTalhoes(1,i) = objeto;
    end
end