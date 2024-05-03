classdef talhao
    
    properties
        id
        idadeInicial
        idadeCorrente
        area
        vetorProducaoIdade
        vetorColheita   
        vetorIdade
    end
    
    methods
        
        function obj = talhao(id, idadeInicial, area, vetorProducaoIdade)
           obj.id = id;
           obj.idadeInicial = idadeInicial;
           obj.idadeCorrente = idadeInicial;
           obj.area = area;
           obj.vetorProducaoIdade = vetorProducaoIdade;
           obj.vetorColheita = zeros(1, 16); 
           obj.vetorIdade(1,1) = idadeInicial;
        end
        
        function producao = getProducao(obj,idade)
            producao = obj.vetorProducaoIdade(1, idade)*obj.area;
        end
        
        function obj = colherTalhao(obj, idade)
            producao = getProducao(obj, obj.idadeCorrente);
            obj.vetorColheita(1,idade) = producao;
            obj.idadeCorrente = 0;
        end
        
        function obj = avancarAno(obj)
            idade = obj.idadeCorrente;
            obj.idadeCorrente = idade +1;
            obj.vetorIdade(1, end+1) = obj.idadeCorrente;
        end
         
    end
end

