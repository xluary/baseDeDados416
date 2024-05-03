function baseDeDados = gerarBaseDeDados(producaoPorIdade,talhoes,idadeCusto, horizontePlanejamento, idadesCorte, precoMetroCubicoMadeira, precoColheita, taxaDeDesconto)
    baseDeDados =[];

    matrizCombinacao = combinarIdadesCortes(idadesCorte); 
    
    [qPrescricoes, ~] = size(matrizCombinacao);
    qTalhoes = talhoes(end, 1);
    
    matrizObjetos = gerarMatrizObjetos(talhoes,producaoPorIdade, matrizCombinacao, horizontePlanejamento, idadeCusto, precoMetroCubicoMadeira, precoColheita, taxaDeDesconto);  

    
    linha=1;
    for i = 1: qTalhoes
        for j = 1: qPrescricoes
            baseDeDados(linha,1) = i;
            baseDeDados(linha, 2) = matrizObjetos(i,j).IdadeInicial;
            baseDeDados(linha,3) = j;
            baseDeDados(linha,4:(3+ horizontePlanejamento)) = matrizObjetos(i,j).VetorProducao;
            baseDeDados(linha,(4+ horizontePlanejamento)) = matrizObjetos(i,j).VPL;
            linha = linha +1;
        end
    end
end

function matrizCombinacao = combinarIdadesCortes(idadesCorte)

    controle = 0;
    for i = idadesCorte(1):idadesCorte(end)
       for j = idadesCorte(1):idadesCorte(end)
           for l = idadesCorte(1):idadesCorte(end)
               for u = idadesCorte(1):idadesCorte(end)
                 controle=controle +1;
                 combinacao = [i,j,l,u];
                 matrizCombinacao(controle,:) = combinacao; 
               end
           end  
       end  
    end  
    
end

function matrizObjetos = gerarMatrizObjetos(talhoes, producaoPorIdade, matrizCombinacao, horizontePlanejamento, idadeCusto, precoMetroCubicoMadeira, precoColheita, taxaDeDesconto)

    [qPrescricoes, ~] = size(matrizCombinacao);
    qTalhoes = talhoes(end, 1);

    for i = 1: qTalhoes
        for j = 1: qPrescricoes
            objeto = talhao_prescricao;
            objeto.Talhao = i;
            objeto.Prescricao = j;
            objeto.IdadeInicial = talhoes(i,2);
            objeto.Area = talhoes(i,3);
            
            objeto.VetorProducaoPorIdade = producaoPorIdade(i,(3:end));
            [vetorColheita, vetorProducao, vetorIdade, idadeFinal] = gerarVetorColheita(objeto, matrizCombinacao, horizontePlanejamento);
            objeto.VetorColheita = vetorColheita;
            objeto.VetorProducao = vetorProducao;
            objeto.VetorIdade = vetorIdade;
            objeto.IdadeFinal = idadeFinal;
           
            [vetorCustoProducao, vetorCustoColheita] = gerarVetorCustoProducao(objeto, horizontePlanejamento, idadeCusto, precoColheita);
            objeto.VetorCustoProducao =  vetorCustoProducao;
            objeto.VetorCustoColheita = vetorCustoColheita;
            
            vetorReceitas = calcularReceitas(objeto, precoMetroCubicoMadeira, horizontePlanejamento);
            objeto.VetorReceitas = vetorReceitas;
            
            lucroFinal = calcularLucroFinal(objeto, idadeCusto, precoMetroCubicoMadeira, precoColheita);
            objeto.LucroFinal = lucroFinal;
            
            vpl=calcularVPL(objeto,horizontePlanejamento,taxaDeDesconto);
            objeto.VPL = vpl;
            
            
            matrizObjetos(i,j)=objeto;
            
        end    
    end    
end