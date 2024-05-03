function [VPLfinal, producaoTotal, VPLunit] = calcularVPL(objetosTalhoes, horizontePlanejamento, precoColheita, taxaDeDesconto, idadeCusto, precoMetroCubicoMadeira, Dmin, Dmax, penalidade)
    [~ , c] = size (objetosTalhoes);
    VPLunit = [];
    for i = 1 : c
        vetorIdade = objetosTalhoes(1,i).vetorIdade;
        vetorColheita = objetosTalhoes(1,i).vetorColheita;
        vetorProducaoIdade = objetosTalhoes(1,i).vetorProducaoIdade;
        area = objetosTalhoes(1,i).area;

        custoManutencao =  calcularCustoManutencao(area, vetorIdade, idadeCusto, horizontePlanejamento);
        custoColheita =  calcularCustoColheita (vetorColheita,  horizontePlanejamento, precoColheita);
        receitaHP = calcularReceitas (precoMetroCubicoMadeira, vetorColheita, vetorIdade, horizontePlanejamento);
       % receitaFinal = calcularReceitaFinal(vetorIdade, vetorProducaoIdade, area, precoMetroCubicoMadeira, horizontePlanejamento);
        receitaFinal = 0;
        VPLtalhao = calcularVPLtalhao(custoManutencao, custoColheita, receitaHP, receitaFinal, taxaDeDesconto, horizontePlanejamento);
        VPLunit(i,1) = VPLtalhao;
        producao(i,:) = vetorColheita;
    end
        producaoTotal = sum(producao);
        penalidadeTotal = calcularPenalidade(producaoTotal, Dmin, Dmax, penalidade);
        VPLfinal =  sum(VPLunit)- penalidadeTotal;
end

function  custoManutencao =  calcularCustoManutencao(area, vetorIdade, idadeCusto, horizontePlanejamento)
    custoManutencao = [];
    for i = 1: horizontePlanejamento
        posicao = vetorIdade (1, i) + 1;
        custo = idadeCusto(posicao, 2);
        custoManutencao(1, i) = custo * area;
    end
end

function custoColheita =  calcularCustoColheita (vetorColheita,  horizontePlanejamento, precoColheita)
    custoColheita = [];
    for i = 1: horizontePlanejamento
         custoColheita(1, i) = vetorColheita (1, i) * precoColheita;
    end
end

function receita = calcularReceitas (precoMetroCubicoMadeira, vetorColheita, vetorIdade, horizontePlanejamento )
    receitas = [];
    for i = 1: horizontePlanejamento
        posicao = vetorIdade(1,i) + 1;
        preco = precoMetroCubicoMadeira(posicao, 2);
        receita(1, i) = vetorColheita(1, i) * preco;
    end
end

 function receitaFinal = calcularReceitaFinal(vetorIdade, vetorProducaoIdade, area, precoMetroCubicoMadeira, horizontePlanejamento)
    idadeCorrente = vetorIdade(1,horizontePlanejamento+1);
    preco = precoMetroCubicoMadeira(idadeCorrente+1, 2);
    producao = vetorProducaoIdade(1, idadeCorrente) * area;
    receitaFinal = producao* preco;
 end

function VPL = calcularVPLtalhao(custoManutencao, custoColheita, receitaHP, receitaFinal, taxaDeDesconto, horizontePlanejamento)
    custos = custoManutencao + custoColheita;
    lucro = receitaHP - custos;
    n=0;
    VPLintermediario = 0;
    for i = 1: horizontePlanejamento
        valorAux = lucro(1,i)/((1+taxaDeDesconto)^n);
        VPLintermediario = VPLintermediario +  valorAux;
        n = n + 1;
    end
    %VPLreceitaFinal = receitaFinal/((1+taxaDeDesconto)^horizontePlanejamento);
    VPL = VPLintermediario;
    %VPL = VPLintermediario + VPLreceitaFinal;
end

function penalidadeTotal = calcularPenalidade(producaoTotal, Dmin, Dmax, penalidade)
    [~, c] = size(producaoTotal);
    excesso = 0;
    for i = 1: c
        if producaoTotal(1, i) < Dmin
           excesso=excesso+(Dmin - producaoTotal(1, i));
        elseif producaoTotal(1, i) > Dmax
           excesso=excesso+(producaoTotal(1, i)- Dmax);
        end      
    end
    penalidadeTotal = excesso * penalidade;
end
