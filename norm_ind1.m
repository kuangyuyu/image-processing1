function  [X,normal] =norm_ind1(x,ind)
% NORM2 nomalizes the data to have zero means and unit covariance

x = double(x);
n=size(x,1);

normal.mean=mean(x(ind,:));
l = length(ind);

x=x-repmat(normal.mean,n,1);
normal.scale=sqrt(sum(sum(x(ind,:).^2,2))/l);
X=x/normal.scale;


