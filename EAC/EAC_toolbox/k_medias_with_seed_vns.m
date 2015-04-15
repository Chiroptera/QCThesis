function [nsamples_in_cluster,clusters_m]=k_medias_with_seed_vns(dados,k,seed_order)

%k_medias(dados,k) retorna a classifica��o das amostras em "dados" pelo m�todo das k-m�dias

%esta fun��o faz o clustering dos dados na matriz "dados" usando o m�todo das
% k-m�dias, com "k" centroides; 
%em vez de retornar um vector de igual dimens�o � matriz de amostras com
% o �ndice de classe para cada padr�o, retorna um matriz, em que cada linha tem o indice das amostras desse cluster

%Ultima altera��o: 27/12/2001

[nsamples cols]=size(dados);

centroides=[];
clusters=zeros(nsamples,1);
nsamples_in_cluster=ones(k,1);

clusters_m=zeros(k,nsamples);

if isempty(seed_order)
   seed_order=(1:k);
end

%inicializa��o dos centroides com os valores das "k" primeiras amostras
for i=1:k
   centroides=[centroides ; dados(seed_order(i),:)];
   clusters(seed_order(i))=i;
end


%primeira fase do algoritmo
for i=1:nsamples
   if (clusters(i)==0)
	   smp=dados(i,:);
   	j=nearest_centroide(smp,centroides);
   	clusters(i)=j;
   	centroides(j,:)= centroides(j,:)*...
      	(nsamples_in_cluster(j)/(nsamples_in_cluster(j)+1)) + ...
      	smp/(nsamples_in_cluster(j)+1);
      nsamples_in_cluster(j)=nsamples_in_cluster(j)+1;
   end	
end


%segunda fase do algoritmo
nsamples_in_cluster=zeros(k,1);
max_ns_in_clusters=0;
for i=1:nsamples
   smp=dados(i,:);
   j=nearest_centroide(smp,centroides);
   clusters(i)=j;
   nsamples_in_cluster(j)=nsamples_in_cluster(j)+1;
   if nsamples_in_cluster(j)> max_ns_in_clusters
      max_ns_in_clusters=nsamples_in_cluster(j);
   end
   clusters_m(j,nsamples_in_cluster(j))=i;
end

%truncar a matriz final:
clusters_m=clusters_m(:,1:max_ns_in_clusters);

