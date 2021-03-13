function [img_ref,categorie_ref,rd] = choisir_image_aleatoirement(rep,nb_images)
% Choisir une image aléatoirement dans la BDD
rng(); % aleatoire
rd = randi([1 12]); % choisir un entier entre 1 et 12 (nombre de dossiers de textures)
list=dir([rep{rd} '*.JPG']); % regarder toutes les images dans le repertoire
nbIm=numel(list);  % compter images dans repertoires
rd_image= randi([nb_images nbIm]); % choisir une image aleatoirement dans le repertoire, en enlevant les images de references

img_ref= imread(sprintf('%s%d.JPG',rep{rd},rd_image));

if rd ==2|| rd ==6
    categorie_ref="lisse";
else
    categorie_ref="pas-lisse";
end
end

