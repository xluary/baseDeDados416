classdef talhao
    
    properties
        Talhao
        Prescricao
        IdadeInicial
        IdadeCorrente
        Area
        VetorProducaoPorIdade
        VetorColheita                
    end
    
    methods
        function producao = getProducao(idade)
            producao = VetorProducaoIdade(1, idade);
        end
        
        function colherTalhao(obj, hP)
            producao = getProducao(obj.IdadeCorrente);
            obj.VetorColheita(1,hP) = producao;
            obj.IdadeCorrente = 0;
        end
        
        function IdadeCorrente = avancarAno(obj)
            idade = obj.IdadeCorrente;
            IdadeCorrente = idade +1;
        end
         
    end
end

