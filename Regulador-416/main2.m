clear all;
close all;
clc;

load("prognose.txt");
talhoesIniciais = load("talhoes.txt");

hpMax = 100;
hp = 16;

opcoesColheita = [5, 6, 7];


[c, ] = size(talhoesIniciais, 1);

DmaxParcial = calcularDmaxInicial (prognose, talhoesIniciais, opcoesColheita);
Dmax = ceil(DmaxParcial/1000) * 1000
Dmin = 0;

objetivo = 1;
alterado = 1;
i=1;
while i < hpMax || alterado ~= 0
  talhoes = talhoesIniciais;

  reiniciar = 0;
  alterado = 0;
  i=1;
  for i = 1: hpMax
    producaoAno = 0;
    condicao = false;

    while condicao == false
      [talhoesOrdenados, qMaisVelho] = ordenarPorIdade(talhoes);
      [talhaoAvaliado] = selecionarTalhao(talhoesOrdenados, qMaisVelho);
      idadeAtual =  talhoes(talhaoAvaliado, 2);

      if idadeAtual < min(opcoesColheita(1,:))
        alterado = 1;
        Dmax = Dmax - 1000
        break;
      end

      area = talhoes(talhaoAvaliado, 3);
      prognoseTalhao = prognose (talhaoAvaliado, 2:end);
      producao = encontrarProducao(prognoseTalhao,idadeAtual, area);
      if objetivo == 2
        a=0;
      end
      if objetivo == 1 && (producaoAno+producao)<= Dmax || objetivo == 2 && producaoAno <= Dmin
        talhoes(talhaoAvaliado, 2) = 0; %modificar idade para zero
        producaoAno = producaoAno + producao;
        solucao(talhaoAvaliado, hp) = producao;
      else
        condicao = true;
      end

    end

    if alterado == 1
      break;
    end

    producaoTotal(1,i)= producaoAno;
    talhoes = avancarAno(talhoes);
end
  i
  if i == hpMax && objetivo == 1
    objetivo= objetivo+1;
    alterado = 1;
  end
  if max(unique(talhoes(:,2))) >= max(opcoesColheita)
    Dmin = Dmin + 1000
    alterado = 1;
  end

end
ocorrencia = contarIguaisColuna (talhoes(:,2));
bar(ocorrencia);
Dmax
Dmin
