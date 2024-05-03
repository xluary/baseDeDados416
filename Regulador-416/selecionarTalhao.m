function talhaoAvaliado = selecionarTalhao(talhoesOrdenados, ocorrencia)
    qTalhoes = ocorrencia(end);   
    opcoesTalhoes = talhoesOrdenados(1:qTalhoes);
    nAleatorio = randi(qTalhoes);
    talhaoAvaliado = opcoesTalhoes(nAleatorio);
end