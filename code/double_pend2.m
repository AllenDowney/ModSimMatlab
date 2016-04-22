function res = double_pendulum()
    syms g m1 m2 l1 l2 positive
    syms V T L real
    syms t th1 th2 om1 om2 aa1 aa2 real

    th1 = sym('th1(t)');
    th2 = sym('th2(t)');
	  
    X1 = pol2vec(l1, th1-pi/2);
    X2 = X1 + pol2vec(l2, th2-pi/2);

    V1 = diff(X1, t);
    V2 = diff(X2, t);

    v1sq = dot(V1, V1);
    v2sq = dot(V2, V2);
    
    V = m1 * g * X1(2) + m2 * g * X2(2);
    T = m1 * v1sq / 2 + m2 * v2sq / 2; 
    L = T - V;
    L = subs(L, {diff(th1,t) diff(th2,t)}, {om1 om2}) 
    simplify(L)

    M = (m1 + m2) / 2 * l1^2 * om1^2 + m2/2 * l2^2 * om2^2 + ...
        m2 * l1 * l2 * om1 * om2 * cos(th1-th2) + ...
	(m1 + m2) * g * l1 * cos(th1) + m2 * g * l2 * cos(th2);

    simplify(L-M);
	
    dLdom1 = diff(L, om1);
    ddt1 = diff(dLdom1, t);
    dLdth1 = diff(L, 'th1');
    EL1 = simplify(ddt1 - dLdth1);
    %pretty(EL1);

    %FL1 = (m1 + m2) * l1 * aa1 + m2 * l2 * aa2 * cos(th1-th2) + ...
    %      m2 * l2 * om2^2 * sin(th1-th2) + g * (m1 + m2) * sin(th1) 

    %diffs = {sin(th1-th2), cos(th1-th2)}
    %expand = {sin(th1) * cos(th2) - cos(th1) * sin(th2),
    %	      cos(th1) * cos(th2) + sin(th1) * sin(th2)}
    %FL1 = subs(FL1, diffs, expand)
	  
    %simplify(EL1 - FL1)
	  
    dLdom2 = diff(L, om2);
    ddt2 = diff(dLdom2, t);
    dLdth2 = diff(L, 'th2');
    EL2 = simplify(ddt2 - dLdth2);
    %solve(EL2, aa2)
    %pretty(EL2);

    FL2 = m2 * l2 * aa2 + m2 * l1 * aa1 * cos(th1-th2) - ...
          m2 * l1 * om1^2 * sin(th1-th2) + m2 * g * sin(th2);

    simplify(EL2 - FL2);
end



function res = mydiff(f, n)
    syms dot1 dot2 t real
    syms th1 th2 om1 om2 aa1 aa2 real
    
    th1ft = 'th1(t)';
    om1ft = diff(th1ft, t);
    aa1ft = diff(th1ft, t, 2);

    th2ft = 'th2(t)';
    om2ft = diff(th2ft, t);
    aa2ft = diff(th2ft, t, 2);

    FT = {aa1ft, om1ft, th1ft, aa2ft, om2ft, th2ft};
    SYM = {aa1, om1, th1, aa2, om2, th2};
    STR = {'aa1', 'om1', 'th1', 'aa2', 'om2', 'th2'};
    
    temp = subs(f, SYM, FT); 
    temp = diff(temp, t, n);
    temp = simplify(temp)
    temp = subs(temp, FT, STR);

    res = temp;
end

function res = pol2vec(r, theta)
    res = r * [cos(theta); sin(theta)];
end

function res = mynorm(V)
    res = (V(1)^2 + V(2)^2) ^ (1/2);
end
