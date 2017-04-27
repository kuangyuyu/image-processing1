function [np,ngrid] = normalization(p,p_u,grid)
% normalization
X = grid.X;
Y = grid.Y;
TX = grid.TX;
TY = grid.TY;

l = size(p,2);
p = [p,p_u];

[np,normal]=norm_ind1(p',1:l);
nX = (X-normal.mean(1))/normal.scale;
nY = (Y-normal.mean(2))/normal.scale;
nTX = (TX-normal.mean(1))/normal.scale;
nTY = (TY-normal.mean(2))/normal.scale;

ngrid.nX = nX;
ngrid.nY = nY;
ngrid.nTX = nTX;
ngrid.nTY = nTY;
