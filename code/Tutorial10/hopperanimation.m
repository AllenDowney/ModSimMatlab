% hopperanimation.m 
% 
% This script does a simple animation of a reaction mass hopper.
%
% It calls hopper.m, which takes the two masses as input, and returns the
% trajectory information.
close all
m1 = .01;    % mass in kg
m2 = .1;    % mass in kg
figure;

[t, M] = hopper(m1, m2);
r = M(1, :);

% create rectangles
narrow = 0.01;
wide = .1;

shiftx = -wide/2;     % shiftx offsets for the rectangle representing the reaction mass;
shifty = wide;        % shifty accounts for the fact that reaction mass position is zero at the initial 
                      % height of the hopper (i.e., negative when loaded)

h1 = rectangle('Position', [r(1), r(2), narrow, wide], ...
                'FaceColor', 'blue');
h2 = rectangle('Position', [r(3)+shiftx, r(4)+shifty, wide, narrow], ...
                'FaceColor', 'red');
axis([-1 1 0 2])

for i=1:length(t);
    % change position of rectangles
    r = M(i, :);
    set(h1,'Position', [r(1), r(2), narrow, wide]);
    set(h2,'Position', [r(3)+shiftx, r(4)+shifty, wide, narrow]);
    drawnow; % wait a little while so that the animation is visible
end

    
