clear variables; close all; clc;
addpath('../data/','../src/');

load('bird.mat');

myVideo = VideoWriter('../plots/bird_b','MPEG-4'); %open video file
myVideo.FrameRate = 30; 
myVideo.Quality = 100;
open(myVideo)

for i=1:m
    q = reshape(X(:,i),ny,nx);
    imshow(uint8(q));
%     set(gcf,'Color','w');
    set(gcf,'Color','k','InvertHardcopy','off');
    pause(0.000001)
    frame = getframe(gcf); %get frame
    writeVideo(myVideo, frame);
end
close(myVideo)