function [g,lambda]=tse_imklt(f,stand)
% tse_imklt computes the KTL transform of a multidimensionnal image.
% [g,lambda]=tse_imklt(f,norm)
% f is the multi-dimensionnal input image, g is the image in the pca domain
% lambda contain the eigenvalues of the covariance matrix. If stand=1, the input
% image is standardized before computing the pca otherwise it is not (default)

if nargin<2, stand=0;end

[m,n,p]=size(f);
nb=m*n;

% Rearranging the input data
data=reshape(f,nb,p);

% Standardization of input
if (stand==1)
  mu=mean(data);
  sigma=std(data);
  g = (data - repmat(mu,nb,1)) ./ repmat(sigma,nb,1);
else
  g = data;
end

% Pca computation
[V D] = eig(cov(g));
lambda=diag(D);

% Sorting eigenvalues in descend order
[lambda,index]=sort(lambda,'descend');
V=V(:,index);

% Projection in Pca space
g=g*V;

% Reshaping of output
g=reshape(g,m,n,p);
