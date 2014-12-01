
function [t, M] = hopper(m1, m2) 
% calculate the trajectory of the hopper for given masses of the 
% post (m1) and the reaction mass (m2) in kg


% Define constants for the hopper
k = 500 % spring constant in N/m
l = 0 % rest length of spring in m
R = .1 % radius of disk in m (drives angle of spring)

% Set the events to capture end of simulation condition
options = odeset('Events', @events); %Stop when we hit the ground

% Set initial conditions
% [postx posty reactionmassx reactionmassy vpostx vposty etc]
init = [0; 0; 0; -.1; 0; 0; 0; 0];

% Calculate the trajectory, with a fixed timestep to facilitate animations.
[t, M] = ode45(@dHopperdt, [0:0.0003:2], init, options);  


    function res = dHopperdt(t, X) 
    % Function that passes back derivatives based on position and velocity

    g = 10;   % acceleration of gravity in m/s^2
    
    % extract position of the two elements as 2-D vectors
    r1 = X(1:2);
    r2 = X(3:4);
    
    % extract velocity of the two elements as 2-D vectors
    v1 = X(5:6);
    v2 = X(7:8);

    % Deal with the rod normal force possibilities
    % make sure that if post is on the ground, it does not move 
    % unless pulled up.
    force = springforce(r1,r2);
    ay1 = -force / m1 - g;
    if r1(2) <= 0 && ay1 < 0
        ay1 = 0;
    end

    % Deal with the reaction mass    
    ay2 = force / m2 - g; 
    ax1 = 0;
    ax2 = 0;

    % Pass out the results
    % note that v1 and v2 are each two elements.
    res = [v1; v2; ax1; ay1; ax2; ay2];


        function res = springforce(r1, r2)
            % simple function to calculate the force in the y direction due
            % to the angled springs
        
            y1 = r1(2);
            y2 = r2(2);
            L = sqrt(R^2 + (y1-y2)^2);
            res = k* (L-l) * (y1-y2) / L;
        end
    end

    function [value, isterminal, direction] = events(t,X)
        % Check if we hit the ground (actually a little below it to avoid
        % floating point issues)
        value = X(2) + 0.01; 
        isterminal = 1;
        direction = -1;
    end
end
