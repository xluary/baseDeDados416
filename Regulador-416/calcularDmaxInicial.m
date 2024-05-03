function Dmax = calcularDmaxInicial(prognose, talhoes, opcoesColheita)
  [l, ~] = size(talhoes);
  Dmax = 0;

  for i = 1:l
    idade = talhoes(i,2);
    area = talhoes(i,3);
    if idade >= min(opcoesColheita)
      producao = prognose(i, idade+1)* area;
      Dmax = Dmax + producao;
    end
  end
end
