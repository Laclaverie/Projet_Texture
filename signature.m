function [sig]=signature(img,numsig)

 switch numsig 
     case 'mean2_1'
         sig=double(mean2(img(:,:,1)));
     case 'mean2_2'
        sig = double(mean2(img));
     case 'mean2_3'
         sig = double(mean2(img(:,:,2)));
     case 'mean2_L'
        sig = double(mean2(img(:,:,1)+img(:,:,2)+img(:,:,3)));
     case 'entropy_1'
         sig=double(entropy(img(:,:,1)));
     case 'entropy_2'
         sig=double(entropy(img(:,:,2)));
     case 'entropy_3'
         sig=double(entropy(img(:,:,3)));
     case 'std2_L'
         sig= double(mean2(img(:,:,1)+img(:,:,2)+img(:,:,3)));
     case 'histo_1'
          sig= imhist(img(:,:,1));
     case 'histo_2'
          sig= imhist(img(:,:,2));
     case 'histo_3'
          sig= imhist(img(:,:,3));
     case 'histo_L'
          img= rgb2gray(img);
          sig=imhist(double(img(:,:,1)));
     case 'histo_64'
         quant=4;
         nb_bin=quant^3 ;
         Iq = floor(img.*256/nb_bin) ;
         Iq = Iq( :, :,1) + quant*Iq( :, :,2) + quant*quant*Iq( :, :,3) ;
         sig=hist(Iq(:),nb_bin);
       
     case 'LBP'
        % à faire
     case 'HOG'
         % à faire
         
 end
end
 
     
 
 
