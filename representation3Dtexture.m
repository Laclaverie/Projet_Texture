function [sig1,sig2,sig3] = representation3Dtexture(repo,num_sig1,num_sig2,num_sig3)
% Donne les points associés dans l'espace des paramètres
% repo : repository : répertoire où sont les textures, numérotés de 1 à N .
% num_sig : nom des paramètres (exemple mean2,std2,hog,...)
%% calcul de la signature pour chaque image de la base et enregistrement dans des tableaux des données de chaque image
rep = repo;
list=dir([rep '*.JPG']);
nbIm=floor(numel(list)/2); % 50 / 50 
for n = 1:nbIm
    % chargement de l'image n
    img = double(imread(sprintf('%s%d.JPG',rep,n)))/256;
    tab{n}=img; % stockage image en question 
    % enregistrement du numero de l'image
    nom{n}=sprintf('%d',n);
    % ajouter eventuel traitement sur l'image couleur avant calcul de la signature
    % ex : changement espace couleur, segmentation .
    % calcul de la signature pour l'image n
        
    sig1{n}=signature(img,num_sig1);
    sig2{n}=signature(img,num_sig2);
    sig3{n}=signature(img,num_sig3);
    
    
    
    
end
sig1= cell2mat(sig1);
sig2= cell2mat(sig2);
sig3= cell2mat(sig3);

 if  strcmp(num_sig1,'LBP') ||strcmp( num_sig1,'HOG')|| strcmp(num_sig1,'histo') % On ne peut pas plot un histogramme
    % On choisit arbitrairement l'écart type des valeurs de l'histogramme
        sig1= std(sig1);
     elseif  strcmp(num_sig2,'LBP') ||strcmp( num_sig2,'HOG')|| strcmp(num_sig2,'histo')
        sig2= std(sig2);
     elseif  strcmp(num_sig3,'LBP') ||strcmp( num_sig3,'HOG')|| strcmp(num_sig3,'histo')
        sig3= std(sig3);
  end



end

