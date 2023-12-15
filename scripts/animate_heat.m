clear variables; close all; clc;
addpath('../data/','../src/');

load('heat.mat');
nx = length(x);
ny = length(y);
m = length(t);

myVideo = VideoWriter('../plots/heat_b','MPEG-4'); %open video file
myVideo.FrameRate = 30; 
myVideo.Quality = 100;
open(myVideo)

for i=1:m
    q = reshape(X(:,i),ny,nx);
    plot_heat(x,y,q);
    clim([0.5*min(X(:)),0.5*max(X(:))])
    set(gcf,'Color','k','InvertHardcopy','off');
    pause(0.000001)
    frame = getframe(gcf); %get frame
    writeVideo(myVideo, frame);
end
close(myVideo)