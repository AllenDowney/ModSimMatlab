% hopperanimation.m 
% 
% This script does a simple animation of a reaction mass hopper.
%
% It calls hopper.m, which takes the two masses as input, and returns the
% trajectory information.
close all
m1=1;
m2=1;
figure;
[t,Y]=hopper(m1,m2);
y=Y(1,:)
h1=rectangle('Position',[y(1),y(2),0.1,1],'FaceColor',[0 0 1]) % create rectangles
h2=rectangle('Position',[y(3)-0.5,y(4)+1,1,0.1],'FaceColor',[1 0 0])
axis([-8 8 0 16])

for i=1:length(t);
    
    set(h1,'Position',[Y(i,1)-0.05,Y(i,2),0.1,1]); % change position of rectangles
    set(h2,'Position',[Y(i,3)-0.5,Y(i,4)+1,1,0.1]);
    drawnow; % wait a little while so that the animation is visible
end

    
