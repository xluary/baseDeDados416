function dataReduzida = organizarProducao (data, hp)
 numFields = size(data,1);
 dataReduzida = [];
 for i = 1 : numFields
     producaoPrescricao1 = data(i, 1).production;
     producaoPrescricao4 = data(i, 4).production;
     producaoPrescricao81 = data(i, 81).production;
     for j = 1 : hp
         if (producaoPrescricao1(1, j) > 0)
            cincoAnos = producaoPrescricao1(1, j);
         end
         if (producaoPrescricao4(1, j) > 0)
            seisAnos = producaoPrescricao4(1, j);
         end
         if (producaoPrescricao81(1, j) > 0)
            seteAnos = producaoPrescricao81(1, j);
         end
     end
    dataReduzida(i, :) = [cincoAnos, seisAnos, seteAnos]; 
 end
end