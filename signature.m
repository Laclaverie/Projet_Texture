function [sig]=signature(img,numsig)

 switch numsig 
     case 'mean2'
        sig=double(mean2(img));
     case 'entropy'
         sig=double(entropy(img));
     case 'histo'
          sig=imhist(img);
     case 'LBP'
        % � faire
     case 'HOG'
         % � faire
 end
end
 
     
 
 
