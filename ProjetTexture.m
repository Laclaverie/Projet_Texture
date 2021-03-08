%% Projet Texture 
%% mise en mémoire de toute la base NG + NGSmall
clc
close all;
clear all;
%% Créer pour le répertoire en question un les sous imagettes
tmp= exist ('spruceSmall');
if tmp==0
    mkdir spruceSmall % créer folder spruceSmall
rep_ref= 'spruce/';
list=dir([rep_ref '*.JPG']);
rep='spruceSmall/';
disp('création du dossier');
nbIm=numel(list);
for n=1:nbIm % Creer les sous imagettes
   
    img = imread(sprintf('%s%d.JPG',rep_ref,n));
    [X,Y]= size(img); % Taille image
    img1=img(1:floor(X/2),1:floor(Y/2));
    img2=img(1:floor(X/2),floor(Y/2)+1:end);
    img3=img(floor(X/2)+1:end,1:floor(Y/2));
    img4=img(floor(X/2):end,floor(Y/2)+1:end);
    
    imwrite(img1,sprintf('%s%d_%d.JPG',rep,n,1));
    imwrite(img2,sprintf('%s%d_%d.JPG',rep,n,2));
    imwrite(img3,sprintf('%s%d_%d.JPG',rep,n,3));
    imwrite(img4,sprintf('%s%d_%d.JPG',rep,n,4));
end
    
end

%% Commencer l'analyse
% Avec histeq on a de très mauvais scores
rep = 'spruce/';
list=dir([rep '*.JPG']);
nbIm=numel(list);

% signature : histogramme des niveaux de gris
% pas de quantification réglable
handle = @histogrammeLBP;
methode = 'histogramme';
quantification = 256;

for n = 1:nbIm
    img = imread(sprintf('%s%d.JPG',rep,n));
    tab{n}=img; 
    nom{n}=sprintf('%d',n);
    sig{n}=feval(handle,img,quantification);
end

%% Analyse du sous repertoire
rep = 'spruceSmall/';
indice = nbIm+1;
for n = 1:nbIm
    for k=1:4
        img = imread(sprintf('%s%d_%d.JPG',rep,n,k));
        tab{indice}=img; 
        nom{indice}=sprintf('%d_%d.JPG',n,k);
        sig{indice}=feval(handle,img,quantification);
        indice = indice+1;
    end
end

% tableau eval 
% images performantes 100% : les 4 filles sortent en premier, donc rang de
% 3.5
%% 
nbPerf = 0;
rep_ref='spruce/';
for i=1:nbIm
    motif = [nom{i} '_']; % image origine pas exploitée - sortie toujours en premier
    srcImg = sprintf('%s%d.JPG',rep_ref,i);
    img = imread(srcImg);
    ref = feval(handle,img,quantification);
    
    for j=1:nbIm*5 % image source + 4 images filles
        comp(j,1) = sum(min(ref,sig{j})); % distance par intersection, plus elle est élévée, plus la similarité est grande
        comp(j,2) = j; % numéro image correspondant
    end
    Trie = sortrows(comp,-1); % tri ordre décroissant cette fois
    
    for num=1:nbIm*5
         classement{num} = nom{Trie(num,2)};
    end
    pos = strmatch(motif,classement);
    
    eval(i,1)= min(pos);
    eval(i,2)= max(pos);
    eval(i,3)= mean(pos);
    if (eval(i,3) == 3.5)
        nbPerf = nbPerf+1;
        perf{nbPerf} = nom{i};
    end
end

% % sauvegarde dans un fichier csv
% fid = fopen('analyse.csv','w');
% 
% fprintf(fid,'%s; %s; %s; %s\n','reference','première position','dernière position','position moyenne');
% for i=1:nbIm
%     fprintf(fid,'%s; %.0f; %.0f; %.2f\n',nom{i},eval(i,:));
% end
% 
% fclose(fid);

% score efficacité global
score = mean(eval(:,3));
fprintf('%s\n\tScore efficacite: %.2f\n\n',methode,score);
imagesOK='';
for sim = 1:nbPerf
    imagesOK = [imagesOK sprintf('\t%s\n',perf{sim})];
end
display(imagesOK);
    
% De 256 à 128, on passe de 19,49 à 19,47. Ensuite, si on baisse encore, on
% remarqie que le pas
%%
%comparaison_histo('spruce',@histogramme,'histogramme',256);
