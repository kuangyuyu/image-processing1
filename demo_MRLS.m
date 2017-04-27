%% MLS for images using points as pivots
%  The same work done for points can be used for images using a dense set
% of points over a grid that cover the image and using the interpolation to
% get all the transformations. The function MLSD2DWarp do exactly this
% work. The same mlsd must be computed to obtain the warping, only the set
% of points is different because a grid is required, so a step must be
% chosen.

% The step size:
step = 10;
sigma = 5;
lambda = 10;
alpha = 1;

warning off;
% Reading an image:
img = imread('face.png');
[h,w,c] = size(img);
[sp,grid] = getGrid(step,h,w);

p_u = [];
% Requiring the pivots:
f=figure; imshow(img);hold on;
op = getpoints;
close(f);

% normalization

p = [sp op];
[np,ngrid] = normalization(p,p_u,grid);

PV = MRLS_Precompute(np,ngrid.nX,ngrid.nY,alpha,lambda,sigma);

% Requiring the new pivots:
figure; imshow(img); hold on; plotpointsLabels(op,'r.');
oq = getpoints;
close(f);

q = [sp oq];
[nq,normalq]=norm_ind1(q',1:size(q,2));


% % The warping can now be computed:
% tic
% imgo = MLS_Nonrigid(img,np,nq,nX,nY,normal,alpha,lambda,sigma);
% t1 = toc;



imgo1 = MRLS_warp(img,nq,grid.TX,grid.TY,ngrid,normalq,PV);


% Plotting the result:
figure; imshow(imgo1); hold on; plotpoints(q,'r.'); hold off
figure;
subplot(1,2,1),imshow(img);                 
subplot(1,2,2),imshow(imgo1); 
imwrite(imgo,'imgo1.jpg');
% figure; imshow(img); hold on; plotpoints(p,'r.'); hold off
