function imgo = MRLS_warp(img,nq,TX,TY,ngrid,normal,PV)

nX = ngrid.nX;
nY = ngrid.nY;
nTX = ngrid.nTX;
nTY = ngrid.nTY;
C = PV.C;
V = PV.V;

% Generating the grid:
v = [nX(:) nY(:)];

%computing warp
sfv = zeros(size(v));
for i = 1:size(sfv,1)
    sfv(i,:) = V(i,:)+C(i,:)*nq;
end

% Computing the displacements:
dxy = sfv-v;
dxT = interp2(nX,nY,reshape(dxy(:,1),size(nX)),nTX,nTY);
dyT = interp2(nX,nY,reshape(dxy(:,2),size(nX)),nTX,nTY);

% Computing the new points:
% ifXT = (nTX+dxT)*normal.yscale+normal.ym(1);
% ifYT = (nTY+dyT)*normal.yscale+normal.ym(2);

ifXT = (nTX+dxT)*normal.scale+normal.mean(1);
ifYT = (nTY+dyT)*normal.scale+normal.mean(2);

% Warping:
tmap = cat(3,2*TX-ifXT,2*TY-ifYT);
resamp = makeresampler('linear','fill');
imgo = tformarray(img,[],resamp,[2 1],[1 2],[],tmap,0);
