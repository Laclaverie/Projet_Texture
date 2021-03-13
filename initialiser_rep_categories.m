function [categories_larges,rep,fin] = initialiser_rep_categories()
% Donne le nom des catégories lisses et pas lisses ( à paufiner)
% Initialise le nom de chaque textures
% Renvoi le nombre de textures présentées 
categories_larges{1,1}= 'lisse';
categories_larges{2,1}= 'beech';
categories_larges{3,1}= 'hornbeam';
categories_larges(4:11,1)= cellstr('non defini');


categories_larges{1,2}= 'pas-lisse';
categories_larges{2,2}= 'alder';
categories_larges{3,2}= 'birch';
categories_larges{4,2}= 'chestnut';
categories_larges{5,2}= 'ginkgoBiloba';
categories_larges{6,2}= 'horseChestnut';
categories_larges{7,2}= 'linden';
categories_larges{8,2}= 'oak';
categories_larges{9,2}= 'orientalPlane';
categories_larges{10,2}= 'pine';
categories_larges{11,2}= 'spruce';



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
end

