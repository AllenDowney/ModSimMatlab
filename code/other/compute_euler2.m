function [ ang ] = compute_euler ( q ) 
% q is a quaternion containing euler parameters
% compute the corresponding euler angles, using the
% formulae from the wikipedia page

q0 = q(1);
q1 = q(2);
q2 = q(3);
q3 = q(4);

y = 2 * (q0*q1 - q2*q3);
x = 1 - 2 * (q1^2 + q2^2);
ang(1) = atan2(y, x);

s = 2 * (q0*q2 - q3*q1);
ang(2) = asin(s);

y = 2 * (q0*q3 - q1*q2);
x = 1 - 2 * (q2^2 + q3^2);
ang(3) = atan2(y, x);

