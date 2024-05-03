function producao = encontrarProducao(prognoseTalhao,idadeAtual, area)
  [~, c] = size(prognoseTalhao);
  if idadeAtual > c
    producaoHA = 1;
  else
    producaoHA = prognoseTalhao(1, idadeAtual);
  end
  producao = producaoHA * area;
end
