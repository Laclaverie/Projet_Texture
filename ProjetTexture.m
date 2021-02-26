%% Projet Texture 
%% mise en mémoire de toute la base NG + NGSmall
clc
close all;
clear all;

% Avec histeq on a de très mauvais scores
rep = 'spruce/';
list=dir([rep '*.JPG']);
nbIm=numel(list);
disp('extraction des caractéristiques sur la base');
%% calcul de la signature pour chaque image de la base et enregistrement dans des tableaux des données de chaque image
num_sig='mean2_2'; % Methode à utiliser
for n = 1:nbIm
    % chargement de l'image n
    img = double(imread(sprintf('%s%d.JPG',rep,n)))/256;
    tab{n}=img; 
    % enregistrement du numero de l'image
    nom{n}=sprintf('%d',n);
    % ajouter eventuel traitement sur l'image couleur avant calcul de la signature
    % ex : changement espace couleur, segmentation .
    % calcul de la signature pour l'image n
    sig{n}=signature(img,num_sig);
end
%% Sélection de l'image requête
numImg = 5;
% extraction des caractéristiques sur l''image requete et calcul de similarité avec la base d''images
disp('extraction des caractéristiques sur l''image requete et calcul de similarité avec la base d''images');

% calcul de la signature sur l'image requete
srcImg = sprintf('%s%d.JPG',rep,numImg);
img =(double(imread(srcImg))/256);
ref =signature(img,num_sig);


% selection de la mesure de similarité : num_sim
% 'ecartabs' : écart en valeur absolue
num_sim='ecartabs';

% calcul de la similarité entre l'image requete et toutes les autres images
for j=1:nbIm
    mes_sim(j,1) = similarite(ref, sig{j},num_sim);
    mes_sim(j,2) = j; % numéro image correspondant
end
Trie = sortrows(mes_sim,1); % tri ordre croissant selon la 1° colonne, basée signature

% resultat affiché
disp('affichage du resultat');

% affiche des 11 plus proches images à l'image de requete selon la mesure de similarité croissante 
subplot(3,4,1); legende=sprintf('n°%s \n imagerequete',nom{numImg+1}); 
imshow(img,[]), title(legende); % affiche l'image requete
for sim=1:11 
    legende=sprintf('n°image %s\n d=%.5e',nom{Trie(sim,2)},Trie(sim,1)); 
    subplot(3,4,sim+1); imshow(tab{Trie(sim,2)},[]); title(legende);
end


