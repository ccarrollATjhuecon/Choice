% For detailed explanations, please see the Mathematica code

clear
clc

%% PARAMETER DEFINITION

Y1 = 1;
RLo = 1;
RHi = 2;
rho = 2;
beta = 0.96;

%% FUNCTIONAL FORMS

% Intertemporal budget constraint and indifference curve
IBC = @(R,C1,Y1) (Y1-C1)*R;
IndCurve = @(V,C1) ((V*(1-rho)-C1^(1-rho))/beta)^(1/(1-rho));

% Optimal solution
C1 = @(R) (R/(R+(R*beta)^(1/rho)))*Y1;
C2 = @(R) C1(R)*(R*beta)^(1/rho);
V = @(R) (C1(R)^(1-rho)/(1-rho))+beta*(C2(R)^(1-rho)/(1-rho));

% Substitution effect
C1Subs = (V(RHi)*(1-rho)/(1+beta*(RLo*beta)^((1-rho)/rho)))^(1/(1-rho));
C2Subs = C1Subs*(RLo*beta)^(1/rho);
Y1Equiv = C1Subs+C2Subs/RLo;

%% PLOT

figure;
hold on;
fplot(@(C1) IBC(RLo,C1,Y1), [0.2 Y1], 'k-');
fplot(@(C1) IndCurve(V(RLo),C1), [0.35 .7], 'k-');
fplot(@(C1) IBC(RHi,C1,Y1), [0.2 Y1], 'k-');
fplot(@(C1) IndCurve(V(RHi),C1), [0.45 .8], 'k-');
fplot(@(C1) IBC(RLo,C1,Y1Equiv), [0.4 Y1], 'k-');
axis([0.2 1 0 (0.8*RHi)])
xlabel('C1')
ylabel('C2')
set(gca, 'XTick', []);
set(gca, 'YTick', []);
text(C1(RLo) + 0.01, C2(RLo) + 0.06, 'A')
text(C1(RHi) + 0.01, C2(RHi) + 0.06, 'C')
text(C1Subs + 0.01, C2Subs + 0.06, 'B')
hold off;
