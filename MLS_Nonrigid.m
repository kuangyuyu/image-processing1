function imgo = MLS_Nonrigid(img,p,q,X,Y,normal,alpha,lambda,sigma)

% Image info:
[h,w,c] = size(img);

% Generating the grid:
v = [X(:) Y(:)];

% Generating the complete grid:
[TX,TY] = meshgrid(1:w,1:h);
nTX = (TX-normal.xm(1))/normal.xscale;
nTY = (TY-normal.xm(2))/normal.xscale;

% Constructing kernel matrix
Gamma = con_K(p, p, sigma);
Gamma_v = con_K(v, p, sigma);

%computing warp
sfv = zeros(size(v));
for i = 1:size(sfv,1)
    W_1 = diag(sum(abs(p-repmat(v(i,:),size(p,1),1)).^(2*alpha),2));
    sfv(i,:) = v(i,:) + Gamma_v(i,:)*inv(Gamma+lambda*W_1)*(q-p);
end

% Computing the displacements:
dxy = sfv-v;
dxT = interp2(X,Y,reshape(dxy(:,1),size(X)),nTX,nTY);
dyT = interp2(X,Y,reshape(dxy(:,2),size(X)),nTX,nTY);

% Computing the new points:
% ifXT = (nTX+dxT)*normal.yscale+normal.ym(1);
% ifYT = (nTY+dyT)*normal.yscale+normal.ym(2);

ifXT = (nTX+dxT)*normal.xscale+normal.xm(1);
ifYT = (nTY+dyT)*normal.xscale+normal.xm(2);

% Warping:
tmap = cat(3,2*TX-ifXT,2*TY-ifYT);
resamp = makeresampler('linear','fill');
imgo = tformarray(img,[],resamp,[2 1],[1 2],[],tmap,0);

%%%%%%%%%%%%%%%%%%%%%%%%
function K=con_K(x,y,sigma)

n=size(x,1); 
m=size(y,1);

K=repmat(x,[1 1 m])-permute(repmat(y,[1 1 n]),[3 2 1]);
K=squeeze(sum(K.^2,2));
K=-K/(sigma^2);
K=exp(K);
