function data = gerarArquivoData (baseDeDados)  
    
    linhas  = baseDeDados(end, 1);
 
    colunas  = baseDeDados(end, 3);

    controleBaseDeDados = 1;
    for i = 1: linhas
        for j = 1: colunas
            field1 = "production";
            field2 = "VPL";
            value1 = baseDeDados(controleBaseDeDados, 4:19);
            value2 = baseDeDados(controleBaseDeDados, 20);
            data(i,j) = struct(field1, value1, field2, value2);
            controleBaseDeDados = controleBaseDeDados +1;
        end

    end
    mat_file = matfile('data.mat');
    save('data.mat', 'data');
end