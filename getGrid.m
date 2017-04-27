function [sp,grid] =getGrid(step,h,w)
hp = unique([1:step*10:h,h]);
wp = unique([1:step*10:w,w]);
hs1 = ones(1,length(hp)) ;
ws1 =  ones(1,length(wp)) ;
hsh = h.*ws1;
wsw = w.*hs1;
sp1 = [hs1',hp'];
sp2 = [wp;ws1]';
sp3 = [wp;hsh]';
sp4 = [wsw',hp'];
sp = [sp1;sp2(2:end-1,:);sp3(2:end-1,:);sp4]';

grid_W = [1:step:w,w];
grid_H = [1:step:h,h];
[X,Y] = meshgrid(grid_W,grid_H);

% Generating the complete grid:
[TX,TY] = meshgrid(1:w,1:h);

grid.X = X;
grid.Y = Y;
grid.TX = TX;
grid.TY = TY;
