function j=nearest_centroide(sample,centroides)

% esta fun��o calcula o indice do centroide em "centroides" 
% mais proximo da amostra "sample". Usa a dist�ncia Euclideana


[k cols]=size(centroides);
dist=norm(sample-centroides(1,:));
j=1;
for i=1:k
   dd=norm(sample-centroides(i,:));
   if dd<dist
      dist=dd;
      j=i;
   end
end
