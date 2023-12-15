clear variables; close all; clc;
addpath('../data/','../src/');

load('bird.mat');
for i=1:m
    q = uint8(reshape(X(:,i),ny,nx));
    imshow(q);
    pause(0.0000001);
end

%% Animate dataset

figure(1)

for k=1:m

    q = reshape(X(:,k),ny,nx);
    imshow(uint8(q));
    pause(0.000001)

end

%% Assess singular values of the data matrix

s = svd(X,'econ');

figure(2);
set(gcf,'DefaultTextInterpreter','Latex','DefaultAxesTickLabelInterpreter','Latex')
semilogy(s,'ko'); xlabel('$k$'); ylabel('$\sigma_k$');

%% Perform DMD

r = 100;
[Phi, rho, b] = DMD(X(:,1:m-1),X(:,2:m),r);
lambda = log(rho)/dt;
[~,i_sort] = sort(abs(imag(lambda)),'ascend');
Phi = Phi(:,i_sort);
b = b(i_sort);
rho = rho(i_sort);
lambda = lambda(i_sort);

disp(lambda);


%% Animate modes

    for j=2:9

        subplot(3,3,j)
        jj = 2*j;
        q = reshape(real( Phi(:,jj)) ,ny,nx);
        q = 255*(q-min(q(:)))/(max(q(:))-min(q(:)));
        imshow(uint8(q));

    end

%%

figure(3)

for k=1:m

    subplot(3,3,1)
    q = reshape(real(Phi(:,3)),ny,nx);
    q = 255*(q-min(q(:)))/(max(q(:))-min(q(:)));
    imshow(uint8(q));
    
    for j=2:9

        subplot(3,3,j)
        jj = 2*j;
        q = reshape(real( Phi(:,jj)*rho(jj)^(k-1) + Phi(:,jj+1)*rho(jj+1)^(k-1) ) ,ny,nx);
        q = 255*(q-min(q(:)))/(max(q(:))-min(q(:)));
        imshow(uint8(q));

    end

    pause(0.000001)

end

%% Low-rank reconstruction

Xr = real(Phi(:,1:r)*diag(b(1:r))*rho(1:r).^(1:m));

figure(4)

for k=1:m
    
    subplot(2,1,1)
    q = reshape(Xr(:,k),ny,nx);
    imshow(uint8(q));

    subplot(2,1,2)
    q = reshape(X(:,k),ny,nx);
    imshow(uint8(q));

    pause(0.000001);

end