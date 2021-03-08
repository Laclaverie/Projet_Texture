%% ** Projet Texture**
%% Commencer l'analyse
close all;
clear all;
clc
rng();
%% Creer images de ref
nb_images_ref = 15;
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
    
tmp= exist ('baseRef');
if tmp==0
    mkdir baseRef 
    for i=1:fin
    rep_ref= rep{i};
    list=dir([rep_ref '*.JPG']);
    for j=1:nb_images_ref
        img=imread(sprintf('%s%d.JPG',rep_ref,1*j)); % je lis une image sur 3
        %figure;imshow(img,[]);
        imwrite(img,sprintf('%s%d_%d.JPG','baseRef/',i,j)); % j'écris
    end

    end
end

%% Recuperer image test
% On prend aleatoirment un répertoire
close all;
rd = randi([1 12]);
list=dir([rep{rd} '*.JPG']);
nbIm=numel(list);
rd_image= randi([1 nbIm]);

img_ref= imread(sprintf('%s%d.JPG',rep{rd},rd_image));

% figure; imshow(img,[]);
%% Creer signatures de chaque images de ref
rep2 = 'baseRef/';
handle = @histogrammeLBP;
nom_methode = 'histo';
switch nom_methode
    case 'histo' % Comparaisons histogrammes
        compteur=1;
         for i = 1:fin
            for j=1:nb_images_ref
                img = imread(sprintf('%s%d_%d.JPG',rep2,i,j));
                tab{compteur}=img; 
                nom{compteur}=sprintf('%d_%d.JPG',i,j);
                %img=graycomatrix(img);
                sig{compteur}=handle(img,256); 
                compteur=compteur +1;
            end
         end
         ref = handle(img_ref,256);
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
        subplot(2,3,1); imshow(img_ref);title(sprintf('%s : numero : %d',rep{rd},rd));
        for sim=1:5 
            legende=sprintf('%s \n %.5f',classement{i},Trie(sim,1));
            subplot(2,3,sim+1); imshow(tab{classement{i}}); title(legende);
        end
        
             
   otherwise % Pas un histogramme
        nhood = [1 1 1];
        compteur=1;
        for i = 1:fin
            for j=1:nb_images_ref
                img = imread(sprintf('%s%d_%d.JPG',rep2,i,j));
                tab{compteur}=img; 
                nom{compteur}=sprintf('%d_%d.JPG',i,j);
                %img=graycomatrix(img);
                if mod(i*j,13)==12
                    figure; imshow(rangefilt(img,nhood),[]);
                end
                sig{compteur}=handle(rangefilt(img,nhood)); 
                compteur=compteur +1;
            end
        end
        ref = handle(img_ref);
        for i=1:fin*nb_images_ref
                comp(i,1) = abs(ref-sig{i}); % écart en valeur absolue
                comp(i,2) = i; % numéro image correspondant
        end
        Trie = sortrows(comp,1);
         % affiche des 5 plus proches, distance croissante 
        subplot(2,3,1); imshow(img_ref);title(sprintf('%s : numero : %d',rep{rd},rd));
        for sim=1:5 
            legende=sprintf('%s \n %.5f',nom{Trie(sim,2)},Trie(sim,1));
            subplot(2,3,sim+1); imshow(tab{Trie(sim,2)}); title(legende);
        end
        

end

% Trie = sort(abs([sig{:}]));


%% test fourrier
%close all;
im = double (imread('alder/15.JPG'));
im=imgaussfilt(im,1);
figure; imshow(im,[]); title('image d''origine');
FT =(fft2(im));
FT(1,1)=1;
FT=fftshift(FT);
logFT= log(abs(real(FT))+1)>6;
%logFT= abs(FT);
figure;imshow(logFT,[]);title('log entier');colorbar;axis on;
[X,Y]= size(logFT);
logFT= logFT(floor(X/2)- 1/10*floor(X/2):floor(X/2)+1/10*floor(X/2), floor(Y/2)+1:end);
figure; imshow(logFT,[]);colorbar; axis on;title('log pas entier');
%% Bon fourrier
close all;
I = double (imread('alder/15.JPG'));

fft2I=fft2(I);
% c :
fftI2(1,1)=0; % On supprime la composante continue ( pour éviter qu'on ne voit que ça sur l'image)
fft2I=fftshift(fft2I); % translation pour avoir l'origine au centre de l'image


fx=(-1/2):1/size(I,2) : ((1/2)-1/size(I,2) ); % axe des abscisses
fy=(-1/2):1/size(I,1) : ((1/2)-1/size(I,1) ); % axe des ordonnées
figure; imagesc(fx,fy,log(abs(fft2I)+1));axis on; title('module du spectre de l''image');colormap('gray') ;colorbar
colormap('gray') ;colorbar

