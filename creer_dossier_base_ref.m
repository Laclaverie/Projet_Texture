function [] = creer_dossier_base_ref(rep,fin,nb_images_ref,quantification)

tmp= exist ('baseRef');
if tmp==0 % si le dossier n'existe pas alors on le créé
    disp('Creation base de reference');
    mkdir baseRef 
    for i=1:fin
    rep_ref= rep{i};
    list=dir([rep_ref '*.JPG']);
    for j=1:nb_images_ref
        img=double(imread(sprintf('%s%d.JPG',rep_ref,1*j))/255); % je lis 
        d= 256/quantification;
        img = floor(img*255/d)/(quantification-1); % Je quantifie
        imwrite(img,sprintf('%s%d_%d.JPG','baseRef/',i,j)); % j'écris
    end

    end
end
end

