function ocorrencia = contarIguaisColuna (lista)
  [l, ~] = size(lista);
  unicos = unique(lista);
  [qUnicos, ~] = size(unicos);
  ocorrencia = zeros(1, qUnicos);
  for j = 1: qUnicos
    nOcorrencia = 0;
    for i = 1: l
      if lista(i) == unicos(j)
        nOcorrencia=ocorrencia+1;
      end
      end
    ocorrencia(1,j) = nOcorrencia;
  end
end
