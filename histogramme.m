function [sig]=histogramme(img,quantification)
% histogramme normalis� des niveaux de gris, avec quantification
% quantification ng dans l'image
    sig = imhist(img,quantification)/(size(img,1)*size(img,2));
end