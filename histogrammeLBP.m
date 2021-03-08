function [h]=histogrammeLBP(I,qq)
% sortie : histogramme normalisé des codes LBP
% non gestion des bords
Nblig=size(I,1);
Nbcol=size(I,2);
qq=2;
% T image des codes LBP, robustesse variations d'éclairement,
% représentation agancement voisinage local

T=uint8(zeros(Nblig,Nbcol));
   
for i=2:Nblig-1
    for j=2:Nbcol-1
        centre = I(i,j);
        if I(i,j-1) >= centre
            T(i,j)=bitset(T(i,j),1);
        end
        if I(i+1,j-1) >= centre
            T(i,j)=bitset(T(i,j),2);
        end
        if I(i+1,j) >= centre
            T(i,j)=bitset(T(i,j),3);
        end
        if I(i+1,j+1) >= centre
            T(i,j)=bitset(T(i,j),4);
        end
        if I(i,j+1) >= centre
            T(i,j)=bitset(T(i,j),5);
        end
        if I(i-1,j+1) >= centre
            T(i,j)=bitset(T(i,j),6);
        end
        if I(i-1,j) >= centre
            T(i,j)=bitset(T(i,j),7);
        end
        if I(i-1,j-1) >= centre
            T(i,j)=bitset(T(i,j),8);
        end
    end
end

h=imhist(T);
h = h./sum(h);
end
