function testes(solucao)
gerarGraficoColheitaTalhao(solucao);
talhoesSemColheita = verificarTalhaoSemColheita(solucao)

end

function gerarGraficoColheitaTalhao(solucao)
    [~, c] = size(solucao);
    x = 1:c;
    y = sum(solucao);
    figure(1);
    bar(x,y)
end

function talhoesSemColheita = verificarTalhaoSemColheita(solucao)
    [l, ~] = size(solucao);
    talhoesSemColheita = [];
    for i=1:l
        if sum(solucao(i,:)) == 0
            talhoesSemColheita(end+1) = i;
        end
    end
end

