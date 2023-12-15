clear variables; close all; clc;
addpath('../data/','../src/');

load('shapes.mat');
m = double(m);
%% Animate dataset

figure(1)

for k=1:m

    q = reshape(real(X(:,k)) ,ny,nx);
    plot_shapes(q);
    clim([-3,3])
    pause(0.0001)

end

%% Assess singular values of the data matrix

s = svd(X,'econ');

figure(2);
set(gcf,'DefaultTextInterpreter','Latex','DefaultAxesTickLabelInterpreter','Latex')
semilogy(s,'ko'); xlabel('$k$'); ylabel('$\sigma_k$');

%% Perform DMD

r = 3;
[Phi, rho, b] = DMD(X(:,1:m-1),X(:,2:m),r);
lambda = log(rho)/dt;

disp(round(lambda,2));


%% Animate modes

figure(3)

for k=1:m

    subplot(1,3,1)
    q = reshape( real(Phi(:,1)*rho(1)^(k-1) + conj(Phi(:,1))*conj(rho(1))^(k-1)) ,ny,nx);
    plot_shapes(q);
    clim([-0.01,0.01]);

    subplot(1,3,2)
    q = reshape( real(Phi(:,2)*rho(2)^(k-1)) ,ny,nx);
    plot_shapes(q);
    clim([-0.2,0.2]);

    subplot(1,3,3)
    q = reshape( real(Phi(:,3)*rho(3)^(k-1) + conj(Phi(:,3))*conj(rho(3))^(k-1)) ,ny,nx);
    plot_shapes(q);
    clim([-0.05,0.05]);

    pause(0.000001);

end

%% Low-rank reconstruction

Xr = real(Phi(:,1:r)*diag(b(1:r))*rho(1:r).^(1:m));

figure(4)

for k=1:m
    
    subplot(2,1,1)
    q = reshape(Xr(:,k),ny,nx);
    plot_shapes(q);
    clim([-3,3]);

    subplot(2,1,2)
    q = reshape(real(X(:,k)),ny,nx);
    plot_shapes(q);
    clim([-3,3]);

    pause(0.000001)

end
