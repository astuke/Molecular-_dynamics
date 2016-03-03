rng(13); 
% MD at constant energy
close all
N=20; % Number of particles 
r=randn(N,2); % positions, 2D system
v=randn(N,2); % velocities, 2D system
temperature=0.1; % scales the initial velocities [.15]
options = optimoptions(@fminunc,'GradObj','on','Algorithm','trust-region');
r = fminunc(@md_potential,r,options); % minimize the potential

plot(r(:,1),r(:,2),'ro');title 'Starting coordinates';
hold on;axis equal;set(gca,'fontsize',20)
pause

kin=.5*sum(sum(v.^2));
v=v.*sqrt(temperature/(kin/N)); % scale initial velocities
kin0=.5*sum(sum(v.^2));
pot0=md_potential(r);

T=15000;
dt=1e-3;
f=md_force(r);
for t=1:T,
    r=r+dt*v+.5*dt^2*f;
    v=v+.5*dt*f;
    f=md_force(r);
    v=v+.5*dt*f;

    if mod(t,100)==0
        pot=md_potential(r);
        kin=.5*sum(sum(v.^2));
        set(gca,'fontsize',20,'XLim',[-2 2], 'YLim', [-2 2])
        subplot(2,2,1), 
        plot(r(:,1),r(:,2),'ko','markerfacecolor',[1 1 1]-.9*[1 1 1]*t/T);
        hold on;axis equal;set(gca,'fontsize',20)
        subplot(2,2,2), plot(t,pot,'o'); hold on;set(gca,'fontsize',20), ylabel('E_{pot}(t)')
        subplot(2,2,3), plot(t,kin,'v'); hold on;set(gca,'fontsize',20), ylabel('E_{kin}(t)')
        subplot(2,2,4), plot(t,pot+kin-pot0-kin0,'+'); hold on;set(gca,'fontsize',20), ylabel('E(t)-E(0)')
        pause(.1)
    end
end
subplot(2,2,1), plot(r(:,1),r(:,2),'bo','markerfacecolor','b'); hold on;title 'coordinates';axis equal
