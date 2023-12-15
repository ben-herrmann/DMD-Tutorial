clear variables; close all; clc;
addpath('../data/','../src/');

load('shapes.mat');

myVideo = VideoWriter('../plots/shapes_b','MPEG-4'); %open video file
myVideo.FrameRate = 15; 
myVideo.Quality = 100;
open(myVideo)

for i=1:size(X,2)
    q = reshape(real(X(:,i)) ,ny,nx);
    plot_shapes(q);
    set(gcf,'Color','k','InvertHardcopy','off');
    clim([-3,3])
    pause(0.00001)
    frame = getframe(gcf); %get frame
    writeVideo(myVideo, frame);
end
close(myVideo)