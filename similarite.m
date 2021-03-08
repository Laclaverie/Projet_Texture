function [mesim]=similarite(data1,data2,numsim)
mesim=0;
 switch numsim 
     case 'ecartabs'
         mesim=abs(data1-data2);
         
     %case 'histo_ecart'
      %  mesim=sum(abs(data1-data2));
     case 'histo_ecart'
     mesim=0;
     for i=1:size(data1,2)
         mesim=mesim+abs(double(data1(i))-double(data2(i)));
     end

     case 'smith'
         mesim=1-(sum(min(data1,data2))/min(sum(data1),sum(data2))); 
     otherwise
         mesim=0;
 end
     
 end
 
     
 
 
