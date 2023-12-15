clear variables; close all; clc;
addpath('../data/','../src/');

load('sst.mat');

%% Animate dataset

figure(1)
for k=1:m

    q = reshape( X(:,k) ,ny,nx);
    plot_sst(x,y,q);
    clim([min(X(:)),max(X(:))])
    pause(0.00001)

end

%% Assess singular values of the data matrix

s = svd(X(~mask,:),'econ');

figure(2);
set(gcf,'DefaultTextInterpreter','Latex','DefaultAxesTickLabelInterpreter','Latex')
semilogy(s,'ko'); xlabel('$k$'); ylabel('$\sigma_k$');

%% Perform DMD

r = 5;
[Phim, rho, b] = DMD(X(~mask,1:m-1),X(~mask,2:m),r);
lambda = log(rho)/dt;
Phi = zeros(n,r);
Phi(mask,:) = NaN;
Phi(~mask,:) = Phim;
[~,i_sort] = sort(abs(b),'descend');
lambda = lambda(i_sort);
rho = rho(i_sort);
Phi = Phi(:,i_sort);
b = b(i_sort);

disp(lambda);

disp(dt*52*imag(lambda)/(2*pi));


%% Animate modes

figure(3)

for k=1:2:m

    subplot(3,1,1)
    q = reshape(real(Phi(:,1)),ny,nx);
    plot_sst(x,y,q);

    subplot(3,1,2)
    q = reshape(real( Phi(:,2)*rho(2)^(k-1) + Phi(:,3)*rho(3)^(k-1) ),ny,nx);
    plot_sst(x,y,q);

    subplot(3,1,3)
    q = reshape(real( Phi(:,4)*rho(4)^(k-1) + Phi(:,5)*rho(5)^(k-1) ) ,ny,nx);
    plot_sst(x,y,q);

    pause(0.0001)

end

%% Low-rank reconstruction

Xr = real(Phi(:,1:r)*diag(b(1:r))*rho(1:r).^(0:m-1));

figure(4)

for k=1:m
    
    subplot(2,1,1)
    q = reshape(Xr(:,k),ny,nx);
    plot_sst(x,y,q);
    clim([min(Xr(:)),max(Xr(:))])

    subplot(2,1,2)
    q = reshape(X(:,k),ny,nx);
    plot_sst(x,y,q);
    clim([min(X(:)),max(X(:))])

    pause(0.02)

end
