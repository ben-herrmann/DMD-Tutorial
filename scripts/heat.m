clear variables; close all; clc;
addpath('../data/','../src/');

load('heat.mat');
[n,m] = size(X);
nx = length(x); ny = length(y);
dt = t(2)-t(1);
Xw = sqrt(W).*X;

%% Animate dataset

figure(1)

for k=1:m

    q = reshape(X(:,k),ny,nx);
    plot_heat(x,y,q);
    clim([0.5*min(X(:)),0.5*max(X(:))])
    pause(0.02)

end

%% Assess singular values of the data matrix

s = svd(Xw,'econ');

figure(2);
set(gcf,'DefaultTextInterpreter','Latex','DefaultAxesTickLabelInterpreter','Latex')
semilogy(s,'ko'); xlabel('$k$'); ylabel('$\sigma_k$');

%% Perform DMD

r = 10;
[Phiw, rho, b] = DMD(Xw(:,1:m-1),Xw(:,2:m),r);
lambda = log(rho)/dt;
[~,i_sort] = sort(real(lambda),'descend');
Phiw = Phiw(:,i_sort);
Phi = Phiw./sqrt(W);
b = b(i_sort);
rho = rho(i_sort);
lambda = lambda(i_sort);

disp(lambda);


%% Plot modes

figure(3)

for k=1:9

    subplot(3,3,k)
    q = reshape(real(Phi(:,k)),ny,nx);
    plot_heat(x,y,q);

end

%% Low-rank reconstruction

r = 10;
Xr = real(Phiw(:,1:r)*diag(b(1:r))*rho(1:r).^(1:m))./sqrt(W);

figure(4)

for k=1:m
    
    subplot(2,1,1)
    q = reshape(Xr(:,k),ny,nx);
    plot_heat(x,y,q);
    clim([0.5*min(Xr(:)),0.5*max(Xr(:))])

    subplot(2,1,2)
    q = reshape(X(:,k),ny,nx);
    plot_heat(x,y,q);
    clim([0.5*min(X(:)),0.5*max(X(:))])

    pause(0.02)

end
