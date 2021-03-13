%% **Projet texture** 
% Potentiellement la derniere version
%% Variables globales 
warning('off','all'); % Supprimer les warnings
close all;
clear all;
clc
nb_images_ref = 10;
quantification= 64;
nb_test=5;
veriteTerrain =[];
sortie_algo=[];
%% Initialiser les categories
[categories_larges,rep,fin] = initialiser_rep_categories();
%% Creer le dossier des images de references
creer_dossier_base_ref(rep,fin,nb_images_ref,quantification);
%% Creer la signature de chaque image de référence
rep_ref = 'baseRef/';
tic;
[sig,nom] = signatures_images_ref(rep_ref,'histogrammeLBP',quantification,fin,nb_images_ref);
toc;
%% choisir une image test aleatoirement dans la banque d'images

for test=1 :nb_test
    tic;
[img_ref,categorie_ref,rd] = choisir_image_aleatoirement(rep,nb_images_ref); % Choisir une image dans le repertoire en enlevant les images de reference
signature_ref= histogrammeLBP(img_ref);
%% La comparer à toutes les signatures
[Trie] = comparer_trier_histo(signature_ref,sig,nb_images_ref,fin);

%% Afficher les resultats
% affiche des 5 plus proches, distance décroissante 
 matches =0;
 figure;
subplot(2,3,1); imshow(img_ref);title(sprintf('%s : n° dossier : %d \n Categorie : %s ',rep{rd},rd,categorie_ref));
for sim=1:5 
    if nom{3,Trie(sim,2)}==categorie_ref
        matches=matches+1;
    end
    legende=sprintf('%s \n %.5f \n Categorie : %s',nom{1,Trie(sim,2)},Trie(sim,1),nom{3,Trie(sim,2)});
    subplot(2,3,sim+1); imshow(tab{Trie(sim,2)}); title(legende);
end  
fprintf('Bonnes categories : %d \n ',matches);

%% Matrice de confusion
veriteTerrain= [veriteTerrain categorie_ref];
sortie_algo = [sortie_algo nom{3,Trie(1,2)}];
toc;
end
% Affichage
c= confusionmat(veriteTerrain,sortie_algo)