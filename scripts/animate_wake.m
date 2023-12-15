clear variables; close all; clc;
addpath('../data/','../src/');

load('wake.mat');

myVideo = VideoWriter('../plots/wake_b','MPEG-4'); %open video file
myVideo.FrameRate = 30; 
myVideo.Quality = 100;
open(myVideo)


for i=1:1:size(X,2)
    q = reshape(X(:,i),ny,nx);
    plot_wake(q);
    clim([0.15*min(X(:)),0.15*max(X(:))]);
    set(gcf,'Color','k','InvertHardcopy','off');
    pause(0.02);
    frame = getframe(gcf); %get frame
    writeVideo(myVideo, frame);
end
close(myVideo)