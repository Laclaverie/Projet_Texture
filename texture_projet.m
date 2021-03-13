%% ** Projet Texture**
%% Commencer l'analyse
warning('off','all');
close all;
clear all;
clc
quantification= 64;
veriteTerrain =[];
sortie_algo=[];
%% Creer images de ref
categories_larges{1,1}= 'lisse';
categories_larges{2,1}= 'beech';
categories_larges{3,1}= 'hornbeam';
categories_larges(4:11,1)= cellstr('non defini');


categories_larges{1,2}= 'pas-lisse';
categories_larges{2,2}= 'alder';
categories_larges{3,2}= 'birch';
categories_larges{4,2}= 'chestnut';
categories_larges{5,2}= 'ginkgoBiloba';
categories_larges{6,2}= 'horseChestnut';
categories_larges{7,2}= 'linden';
categories_larges{8,2}= 'oak';
categories_larges{9,2}= 'orientalPlane';
categories_larges{10,2}= 'pine';
categories_larges{11,2}= 'spruce';



rep=[];
    rep{1} = 'alder/';
    rep{2} = 'beech/';
    rep{3} = 'birch/';
    rep{4}= 'chestnut/';
    rep{5} = 'ginkgoBiloba/';
    rep{6} = 'hornbeam/';
    rep{7} = 'horseChestnut/';
    rep{8} = 'linden/';
    rep{9} = 'oak/';
    rep{10} = 'orientalPlane/';
    rep{11} = 'pine/';
    rep{12} = 'spruce/';
    fin= length(rep);
 
nb_images_ref = 15;

%% Creer le dossier des images de references
tmp= exist ('baseRef');
if tmp==0
    disp('Creation base de reference');
    mkdir baseRef 
    for i=1:fin
    rep_ref= rep{i};
    list=dir([rep_ref '*.JPG']);
    for j=1:nb_images_ref
        img=imread(sprintf('%s%d.JPG',rep_ref,1*j)); % je lis une image sur 3
        %img= floor(img.*256/quantification);
        %thresh= multithresh(img,nb_quantification); % 20 niveaux de quantification
        %img= imquantize(img,thresh);
        %figure;imshow(img,[]);
        imwrite(img,sprintf('%s%d_%d.JPG','baseRef/',i,j)); % j'écris
    end

    end
end

%% Recuperer image test
for nb_img_test =1 : 5
   
% On prend aleatoirment un répertoire
close all;
disp('prendre une image aleatoire');
rng();
rd = randi([1 12]);
list=dir([rep{rd} '*.JPG']);
nbIm=numel(list);
rd_image= randi([1 nbIm]);

img_ref= imread(sprintf('%s%d.JPG',rep{rd},rd_image));
%img_ref= floor(img_ref.*256/quantification); % quantifier
%thresh= multithresh(img_ref,nb_quantification); % 20 niveaux de quantification
%img_ref= imquantize(img_ref,thresh); % quantifier
if rd ==2|| rd ==6
    categorie_ref="lisse";
else
    categorie_ref="pas-lisse";
end
%img_ref= imread(sprintf('%s%d.JPG','alder/',rd_image));
% figure; imshow(img,[]);
%% Creer signatures de chaque images de ref

rep2 = 'baseRef/';
handle = @histogrammeLBP;
nom_methode = 'histo';
switch nom_methode
    
    case 'histo' % Comparaisons histogrammes
        compteur=1;
        disp('creer les signatures');
        for i = 1:fin
            for j=1:nb_images_ref
                img = imread(sprintf('%s%d_%d.JPG',rep2,i,j));
               %img= floor(img.*256/quantification); % quantifier
               %thresh= multithresh(img,nb_quantification); % 20 niveaux de quantification 
               %img= imquantize(img,thresh); % quantifier
                tab{compteur}=img; 
                nom{1,compteur}=sprintf('%d_%d.JPG',i,j);
                nom{2,compteur}=i; % Categorie de l'image
                if i==2|| i==6
                    nom{3,compteur}="lisse";
                else
                    nom{3,compteur}="pas-lisse";
                end
                    
                %img=graycomatrix(img);
                if mod(i*j,13)==12
                   % figure; imshow(rangefilt(img,nhood),[]);
                end
                sig{compteur}=handle(img,quantification);
                %sig{compteur}=handle(entropyfilt(img));
                compteur=compteur +1;
            end
        end
         ref = handle(img_ref,quantification);
         for i=1:fin*nb_images_ref
            comp(i,1) = sum(min(ref,sig{i})); % distance par intersection, plus elle est élévée, plus la similarité est grande
            comp(i,2) = i; % numéro image correspondant
         end
         Trie = sortrows(comp,-1);
         for i=1:fin*nb_images_ref
             if Trie(i,2)~=0
             classement{i} = nom{Trie(i,2)};
             else
                 classement{i} = nom{Trie(i,2)};
             end
         end
         

         % affiche des 5 plus proches, distance décroissante 
         matches =0;
         figure;
       subplot(2,3,1); imshow(img_ref);title(sprintf('%s : n° dossier : %d \n Categorie : %s ',rep{rd},rd,categorie_ref));
       %subplot(2,3,1); imshow(img_ref);title(sprintf('%s : numero : %d','alder/',rd));
        for sim=1:5 
            if nom{3,Trie(sim,2)}==categorie_ref
                matches=matches+1;
            end
            legende=sprintf('%s \n %.5f \n Categorie : %s',nom{1,Trie(sim,2)},Trie(sim,1),nom{3,Trie(sim,2)});
            subplot(2,3,sim+1); imshow(tab{Trie(sim,2)}); title(legende);
        end  
        fprintf('Bonnes categories : %d \n ',matches);
        
             
   otherwise % Pas un histogramme
        %nhood = [1 1 1];
        disp('creer les signatures');
        compteur=1;
        for i = 1:fin
            for j=1:nb_images_ref
                img = imread(sprintf('%s%d_%d.JPG',rep2,i,j));
                %img= floor(img.*256/quantification);
                %thresh= multithresh(img,nb_quantification); % 20 niveaux de quantification
                %img= imquantize(img,thresh);% quantifier
                tab{compteur}=img; 
                nom{1,compteur}=sprintf('%d_%d.JPG',i,j);
                nom{2,compteur}=i; % Categorie de l'image
                if i==2|| i==6
                    nom{3,compteur}="lisse";
                else
                    nom{3,compteur}="pas-lisse";
                end
                    
                %img=graycomatrix(img);
                if mod(i*j,13)==12
                   % figure; imshow(rangefilt(img,nhood),[]);
                end
                sig{compteur}=handle((img));
                %sig{compteur}=handle(entropyfilt(img));
                compteur=compteur +1;
            end
        end
        ref = handle((img_ref));
        for i=1:fin*nb_images_ref
                comp(i,1) = abs(ref-sig{i}); % écart en valeur absolue
                comp(i,2) = i; % numéro image correspondant
        end
        Trie = sortrows(comp,1);
         % affiche des 5 plus proches, distance croissante 
         matches =0;
         figure;
       subplot(2,3,1); imshow(img_ref);title(sprintf('%s : n° dossier : %d \n Categorie : %s ',rep{rd},rd,categorie_ref));
       %subplot(2,3,1); imshow(img_ref);title(sprintf('%s : numero : %d','alder/',rd));
        for sim=1:5 
            if nom{3,Trie(sim,2)}==categorie_ref
                matches=matches+1;
            end
            legende=sprintf('%s \n %.5f \n Categorie : %s',nom{1,Trie(sim,2)},Trie(sim,1),nom{3,Trie(sim,2)});
            subplot(2,3,sim+1); imshow(tab{Trie(sim,2)}); title(legende);
        end  
        fprintf('Bonnes categories : %d \n ',matches);

end

% Trie = sort(abs([sig{:}]));
%% Matrice de confusion
veriteTerrain= [veriteTerrain categorie_ref];
sortie_algo = [sortie_algo nom{3,Trie(1,2)}];

end
c= confusionmat(veriteTerrain,sortie_algo)
%%
% color = lines(2); % Generate color values 2 categories 
% 
% Categorie = ["lisse" "pas-lisse"];
% X = Acceleration;
% Y = MPG;
% nombreCategorie=4;
% 
% ax1 = subplot(1,1,1); % Left subplot
% gscatter(X,Y,Categorie,color(1:nombreCategorie,:));
% title('Title');
