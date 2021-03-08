function [sig]=signature(img,numsig)

 switch numsig 
     case 'mean2'
        sig=double(mean2(img));
     case 'entropy'
         sig=double(entropy(img));
     case 'moment3'
         sig=double(moment(img,3));
     case 'histo'
          sig=imhist(img);
     case 'LBP'
        sig = histogrammeLBP(img);
     case 'HOG'
         sig= histogrammeGradientsOrientes(img,250);
     otherwise
        sig = 0;
     
         
 end
end
 
     
 
 
