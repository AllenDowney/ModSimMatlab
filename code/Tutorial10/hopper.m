
function [t,Y]=hopper(m1,m2) % calculate the trajectory of the hopper for given masses of the post and the reaction mass

% Define constants for the hopper
k=1000 % spring constant
l=0 % rest length of spring
R=1 % radius of disk (drives angle of spring)

% Set the events to capture end of simulation condition
options=odeset('Events',@events); %Stop when we hit the ground

% Set initial conditions
X=[0;0;0;-1;0;0;0;0]; % [postx posty reactionmassx reactionmassy vpostx vposty etc]

% Calculate the trajectory, with a fixed timestep to facilitate animations.
[t,Y]=ode45(@dHopperdt,[0:0.003:10],X,options);  


    function res=dHopperdt(t,X) % Function that passes back derivatives based on position and velocity

    g=10;
    r1=X(1:2);
    r2=X(3:4);
    v1=X(5:6);
    v2=X(7:8);

    % Deal with the rod normal force possibilities
    if r1(2)<=0
        ay1=max(-springforce(r1,r2)/m1 - g,0); % make sure that if post is on the ground, it does not move unless pulled up.
    else
        ay1=-springforce(r1,r2)/m1 - g;
    end

    % Deal with the reaction mass    
    ay2=springforce(r1,r2)/m2 - g; 
    ax1=0;
    ax2=0;

    % Pass out the results
    res=[v1;v2;ax1;ay1;ax2;ay2]; % note that v1 and v2 are each two elements.


        function res=springforce(r1,r2)
            % simple function to calculate the force in the y direction due
            % to the angled springs
        
            y1=r1(2);
            y2=r2(2);
            res=k*(sqrt(R^2+(y1-y2)^2)-l)*(y1-y2)/sqrt(R^2+(y1-y2)^2);
        end


    end
    function [value, isterminal,direction] = events(t,X)
            value=X(2)+0.1; % Check if we hit the ground (actually a little below it to avoid errors associated with the if statement)
            isterminal=1;
            direction=-1;
    end
end