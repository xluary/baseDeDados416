function pais = metselecao(POP,VPL,metSEL)   
    switch metSEL
        case 1
            pais=torneio(POP,VPL);
        case 2
            valorProb = ValorPrR(VPL);
            pais = selecaoroleta(valorProb,POP);
        case 3
            pais = aleatorio(POP);
        case 4
            s=1.8;
            valorProb = rankinglinear(POP,VPL,s);
            pais = selecaoroleta(valorProb,POP);
        case 5
            t0=10^20;
            Rt=1;
            valorProb = Boltzmann(POP,VPL,t0,Rt,j);
            pais = selecaoroleta(valorProb,POP);
         case 6   
            valorProb = Escalonamento(POP,VPL);
            pais = selecaoroleta(valorProb,POP);
    end
end
function pais = selecaomista(POP,VPL,telite,tsorteados)
    [~,ind]= sort(VPL);
    [l,~]=size(POP);
    trale=l-telite;
    elite=ind(trale+1:end);
    rale=ind(1:trale);
    tamanhoprob= size(rale,1); %retorna o tamanho da populacao
    sortudos=randperm(tamanhoprob,tsorteados); 
    b=tamanhoprob-tsorteados;
    selecionados= zeros(b,120); %gera matriz de zeros do tamanho da populacao    
    
    for i = 1:b %tamanho da populacao
        ind1 = ceil(tamanhoprob*rand(1)); %retorna um numero aleatorio de 1 ao tamanho da populacao
        ind2 = ceil(tamanhoprob*rand(1)); %retorna um numero aleatorio de 1 ao tamanho da populacao
        if VPL(ind1) < VPL(ind2) %se o fitnes do indivio 1 for menor que o do individuo 2
            menor = ind1; %salva 1 como menor
            maior = ind2; %salva 2 como maior
        else %se não
            menor = ind2; %salva 2 como menor
            maior = ind1; %salva 1 como maior
        end    
    selecionados(i,:) = POP(maior,:); %adiciona o maior na populacao
    end
    
    selecionados=[selecionados;POP(sortudos,:)];
    POPelite=POP(elite,:);
    ordenados=[selecionados;POPelite];
    aleatorizar=randperm(l);
    pais=ordenados(aleatorizar,:);
end

function pais = selecaoroleta(valorProb,POP)

tamanho = length(valorProb); %10 tamanho da populacao

    for i = 2:tamanho 
        valorProb(i) = valorProb(i) + valorProb(i-1); %descobre o valor da probabilidade final para definir o numero entre 0 e 1
    end 
    
    for i = 1:tamanho %10
            sorteado = rand(1); %gera um número aleatório entre 0 e 1
            for j = 1:tamanho 
                if sorteado <= valorProb(j) %se o numero selecionado for menor que a probabilidade do numero avaliado
                   pais(i,:) = POP(j,:); %adiciona selecionado na populacao
                    break;
                end    
            end
    end  
end

function pais = aleatorio(POP)
tamPOP=size(POP,1);
    for i=1:tamPOP
        r=randperm(tamPOP,1);
        pais(i,:)=POP(r,:);
    end
end

function valorProb = rankinglinear(POP,VPL,s)

[~,ind]= sort(VPL,'descend');
oPOP=POP(ind,:);
oVPL=VPL(ind,:);
tamPOP=size(POP,1);
R=(1:tamPOP);
Ranking=sort(R,'descend');
    for i=1:tamPOP
        P(i,:)=(((2-s)/tamPOP)+ 2 * Ranking(i) * (s-1)/tamPOP*(tamPOP-1));
    end
    Pf=P/sum(P);    
    valor(ind)=Pf;
    valorProb=valor';
end

function valorProb = ValorPrR(VPL)
[~,ordvpl]=sort(VPL);
min=VPL(ordvpl(1));
max=VPL(ordvpl(end));
delta=max-min;
if delta==0 || min>=0
    FX=VPL;
else
    FX=VPL+abs(min);

end
totalFitness = sum(FX); %soma todos os fitness
valorProb = FX/totalFitness; %pega as probabilidadesde cada um ser escolhido
end

function valorProb = Boltzmann(POP,VPL,t0,Rt,k)
[~,ordvpl]=sort(VPL);
min=VPL(ordvpl(1));
max=VPL(ordvpl(end));
FX=(VPL-min)/(max-min);

tamPOP=size(POP,1);
tk=t0*(1-(Rt/100))^k;
B=exp(FX/tk);
if B>10^100
    B=ones(tamPOP,1);
end
total=sum(B)/tamPOP;
valor=B/total;
valorProb=valor/sum(valor);
end

function valorProb = Escalonamento(POP,VPL)
if min(VPL)>0
    FX=VPL;
else
    FX=VPL+(min(VPL)*-1)+1;
end
tamPOP=size(POP,1);
media=mean(FX);
desviopadrao=std(FX);
    if desviopadrao == 0
        e=ones(tamPOP,1);
    else
        e=1.5+(((FX-media)/(2*desviopadrao)));
    end
    valorProb=e/sum(e);
end

function selecionados = torneio(POP,fitness)
    selecionados= zeros(size(POP)); %gera matriz de zeros do tamanho da populacao
    tamanhoprob= size(POP,1); %retorna o tamanho da populacao
    
    for i = 1:tamanhoprob %tamanho da populacao
        ind1 = ceil(tamanhoprob*rand(1)); %retorna um numero aleatorio de 1 ao tamanho da populacao
        ind2 = ceil(tamanhoprob*rand(1)); %retorna um numero aleatorio de 1 ao tamanho da populacao
        if fitness(ind1) < fitness(ind2) %se o fitnes do indivio 1 for menor que o do individuo 2
            menor = ind1; %salva 1 como menor
            maior = ind2; %salva 2 como maior
        else %se não
            menor = ind2; %salva 2 como menor
            maior = ind1; %salva 1 como maior
        end    
    selecionados(i,:) = POP(maior,:); %adiciona o maior na populacao
    end
end