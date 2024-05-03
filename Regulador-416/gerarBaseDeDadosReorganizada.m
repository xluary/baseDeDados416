function baseDeDadosReorganizada = gerarBaseDeDadosReorganizada (horizontePlanejamento, baseDeDados)
qTalhoes = baseDeDados(end, 1);
 
qPrescricoes = baseDeDados(end, 3);

baseDeDadosReorganizada = zeros(qTalhoes*horizontePlanejamento, qPrescricoes+2);

controleLinha = 1;
controleColuna = 3;
posicaoProducaoBdLinha = 1;
    for i = 1: horizontePlanejamento
        for j = 1: qTalhoes
            baseDeDadosReorganizada(controleLinha, 1)= j; %armazena na primeira coluna o talhão
            baseDeDadosReorganizada(controleLinha, 2) = i; %armazena na segunda coluna o ano do horizonte de planejamento

            %TODO percorrer todas as prescrições daquele ano
            for k = 1: qPrescricoes
                posicaoProducaoBdColuna = i+3;

                producao = baseDeDados(posicaoProducaoBdLinha, posicaoProducaoBdColuna);

                if producao>0
                   baseDeDadosReorganizada(controleLinha, controleColuna)  = k; %armazena prescricao
                   controleColuna = controleColuna + 1;
                end

                posicaoProducaoBdLinha = posicaoProducaoBdLinha + 1;


            end
            controleColuna = 3;
            controleLinha = controleLinha +1;
        end
        posicaoProducaoBdLinha = 1;
    end
    mat_file = matfile('dataReorganizada.mat');
    save('dataReorganizada.mat', 'baseDeDadosReorganizada');
end
