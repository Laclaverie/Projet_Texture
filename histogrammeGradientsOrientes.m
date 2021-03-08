% HOG : histogramme normalisé en sortie
function [hog] = histogrammeGradientsOrientes(img,seuil)

% calcul et représentation du vecteur gradient
% Jx -> dérivée selon lignes soit application 
% -1
% 0
% 1
% Jy -> dérivée selon colonnes soit application 
% -1 0 1
[Jy, Jx] = gradient(double(img));
norm = sqrt(Jx.*Jx+Jy.*Jy);

th=atan2(Jy,Jx);
th2=th*180/pi;

v=th2(find(norm >= seuil)); % conservation des seuls pixels où la norme du gradient est supérieure à un seuil

hog(1) = sum(v >= -22.5 & v < 22.5)/length(v); 
hog(2) = sum(v >= 22.5 & v < 67.5)/length(v);
hog(3) = sum(v >= 67.5 & v < 112.5)/length(v); 
hog(4) = sum(v >= 112.5 & v < 157.5)/length(v); 
hog(5) = sum(v >= 157.5 | v < -157.5)/length(v); 
hog(6) = sum(v >= -157.5 & v < -112.5)/length(v); 
hog(7) = sum(v>= -112.5 & v < -67.5)/length(v); 
hog(8) = sum(v >= -67.5 & v < -22.5)/length(v); 
end
