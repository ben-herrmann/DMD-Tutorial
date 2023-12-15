function [Phi, rho, b] = DMD(X,Y,r)

[U,S,V] = svd(X,'econ');       % Step 1
Ur = U(:,1:r);
Sr = S(1:r,1:r);
Vr = V(:,1:r);

Atilde = (Ur'*Y)*(Vr/Sr);     % Step 2
[W,Lambda] = eig(Atilde);     % Step 3
rho = diag(Lambda);

Phi = Y*(Vr/Sr)*W;            % Step 4
b = Phi\X(:,1);               % Step 5
