function [Trie] = comparer_trier_histo(ref,sig,nb_images_ref,fin)
% Comparer les signatures des images (histogrammes ici) et trier par ordre
% d�croissant de similarit� (car si les histogrammes sont similaires alors
% ils ont des signatures qui se resemblent

for i=1:fin*nb_images_ref
    comp(i,1) = sum(min(ref,sig{i})); % distance par intersection, plus elle est �l�v�e, plus la similarit� est grande
    comp(i,2) = i; % num�ro image correspondant
 end
 Trie = sortrows(comp,-1);
 
end

