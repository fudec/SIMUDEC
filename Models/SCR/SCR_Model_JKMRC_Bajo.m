function [y,win] = SCR_Model_JKMRC_Bajo(X,In)
global v rol ros
x= X(1:end-1);
win = X(end);
A0 = 64;
A0 = A0/100;
w = 3.048;
L = 10.97;
LA = 63;
TPH = sum(x);
F1 = 3000;
F2 = 0;
gamma = 1.86;
K = [3.5 -0.004  0 0 -8.5 0 0.035 0.0025 -0.0015];
f= x/TPH*100;
dc = LA*0.97;
d1 = 0;
d2 = 0;
P1 = [];
dk  = min(v);
if dk == 0.001
    dk = v(end-1);
    pos = 2;
else
    pos = 1;
end

if pos == 2
    mkf = f(end-1)/100;
else 
    mkf = 0;
end
F = TPH/w;
Fk = mkf*F;

P2 = 0;
for i = length(v):-1:1
    if v(i) < dc
        P2 = f(i) + P2;
    end
end
if d1~=0 && d2 ~=0
    P1 = 0;
    for i = length(v):-1:1
        if d1 < v(i) < d2
            P1 = f(i) + P1;
        end
    end
end

    P2 = 0;
    for i = length(v):-1:1
        if v(i) < dc
            P2 = f(i) + P2;
        end
    end
    
    
if F < F1
    if isempty(P1)
        P1 = 0;
    end
    n = exp(K(1)+K(2)*F+K(3)*P1+K(4)*P2);
elseif F1 <= F <= F2
    n = exp(K(5)+K(6)*F+K(3)*P1+K(4)*P2);
elseif F > F2
    n = exp(K(5)+K(6)*F2+K(3)*P1+K(4)*P2);
end

SF = K(7) + K(8)*100*mkf+K(9)*Fk;

As = 0;
for i = 1:length(v)-1
    As = As + (f(i)/100*TPH/ros)/((v(i)+ v(i+1))/2);
end

Ff0 = SF*As;

for i = 1:length(v)
    if v(i) > LA
        Eo(i) = 1;
    else
        Eo(i) = exp(-n*A0*(1-v(i)/LA).^gamma);
    end
end
y = (1-Eo).*x;
y(end) = y(end)-Ff0;
end

