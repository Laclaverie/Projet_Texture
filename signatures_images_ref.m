function [sig,nom,tab] = signatures_images_ref(rep2,nom_methode,quantification,fin,nb_images_ref)
% Creer la signature de chaque image de references, pour ensuite dans le
% code, les comparer avec l'image test (pas ici)
nom = cell (3,nb_images_ref*fin);
tab= cell(1,nb_images_ref*fin);
sig= cell(1,nb_images_ref*fin);
switch nom_methode
    
    case 'histogrammeLBP' % Comparaisons histogrammes
        compteur=1;
        disp('creer les signatures');
        for i = 1:fin
            for j=1:nb_images_ref
                img = double(imread(sprintf('%s%d_%d.JPG',rep2,i,j))/255);
                d= 256/quantification;
                img = floor(img*255/d)/(quantification-1); % Je quantifie
                tab{compteur}=img; 
                nom{1,compteur}=sprintf('%d_%d.JPG',i,j);
                nom{2,compteur}=i; % Categorie de l'image
                if i==2|| i==6
                    nom{3,compteur}="lisse";
                else
                    nom{3,compteur}="pas-lisse";
                end
                sig{compteur}=histogrammeLBP(img,quantification);
                compteur=compteur +1;
            end
        end
        otherwise % Pas un histogramme

        disp('creer les signatures');
        compteur=1;
        for i = 1:fin
            for j=1:nb_images_ref
                img = double(imread(sprintf('%s%d_%d.JPG',rep2,i,j))/255);
                d= 256/quantification;
                img = floor(img*255/d)/(quantification-1); % Je quantifie
                tab{compteur}=img; 
                nom{1,compteur}=sprintf('%d_%d.JPG',i,j);
                nom{2,compteur}=i; % Categorie de l'image
                if i==2|| i==6
                    nom{3,compteur}="lisse";
                else
                    nom{3,compteur}="pas-lisse";
                end

                sig{compteur}=handle((img));

                compteur=compteur +1;
            end
        end
end

