clear variables; close all; clc;
addpath('../data/','../src/');

load('wake.mat');
[n,m] = size(X);

%% Animate dataset

figure(1)

for k=1:m

    q = reshape( X(:,k) ,ny,nx);
    plot_wake(q);
    clim([0.15*min(X(:)),0.15*max(X(:))])
    pause(0.02)

end

%% Assess singular values of the data matrix

s = svd(X,'econ');

figure(2);
set(gcf,'DefaultTextInterpreter','Latex','DefaultAxesTickLabelInterpreter','Latex')
semilogy(s,'ko'); xlabel('$k$'); ylabel('$\sigma_k$');

%% Perform DMD

r = 7;
[Phi, rho, b] = DMD(X(:,1:m-1),X(:,2:m),r);
lambda = log(rho)/dt;

disp(lambda);


%% Animate modes

figure(3)

for k=1:m

    subplot(3,1,1)
    q = reshape(real(Phi(:,1)),ny,nx);
    plot_wake(q);

    subplot(3,1,2)
    q = reshape(real( Phi(:,2)*rho(2)^(k-1) + Phi(:,3)*rho(3)^(k-1) ),ny,nx);
    plot_wake(q);

    subplot(3,1,3)
    q = reshape(real( Phi(:,4)*rho(4)^(k-1) + Phi(:,5)*rho(5)^(k-1) ) ,ny,nx);
    plot_wake(q);

    pause(0.02)

end

%% Low-rank reconstruction

r = 5;
Xr = real(Phi(:,1:r)*diag(b(1:r))*rho(1:r).^(1:m));

figure(4)

for k=1:m
    
    subplot(2,1,1)
    q = reshape(Xr(:,k),ny,nx);
    plot_wake(q);
    clim([0.15*min(Xr(:)),0.15*max(Xr(:))])

    subplot(2,1,2)
    q = reshape(X(:,k),ny,nx);
    plot_wake(q);
    clim([0.15*min(X(:)),0.15*max(X(:))])

    pause(0.02)

end
