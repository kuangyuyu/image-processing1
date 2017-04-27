function PV = MRLS_Precompute(np,nX,nY,alpha,lambda,sigma)
% Generating the grid:
v = [nX(:) nY(:)];

% Constructing kernel matrix
Gamma = con_K(np, np, sigma);
Gamma_v = con_K(v, np, sigma);

%computing warp
V = zeros(size(v));
C = zeros(size(v,1),size(np,1));
for i = 1:size(v,1)
    W_1 = diag(sum(abs(np-repmat(v(i,:),size(np,1),1)).^(2*alpha),2));
    C(i,:) = Gamma_v(i,:)/(Gamma+lambda*W_1);
    V(i,:) = v(i,:) - C(i,:)*np;
end

PV.C = C;
PV.V = V;

%%%%%%%%%%%%%%%%%%%%%%%%
function K=con_K(x,y,sigma)

n=size(x,1); 
m=size(y,1);

K=repmat(x,[1 1 m])-permute(repmat(y,[1 1 n]),[3 2 1]);
K=squeeze(sum(K.^2,2));
K=-K/(sigma^2);
K=exp(K);
