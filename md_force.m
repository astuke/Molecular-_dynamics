function [ force ] = md_force( r )
%calculates force between particles from the Coulomb+harmonic potential

N=length(r(:,1)); % assumming first index to be particle index
force=-2*r; % force from the harmonic potential
ff=zeros(N,N,2);
a=1000;
for i=1:N,
    for j=i+1:N,
        % force between particles i and j (normalized)
        ff(i,j,:)=(-1)^i*(-1)^j*(r(i,:)-r(j,:))./norm(r(i,:)-r(j,:))^3+(2*a*(r(i,:)-r(j,:)))./norm(r(i,:)-r(j,:))^4;
        ff(j,i,:)=-ff(i,j,:);
    end
end
for i=1:N,
    % Summing force from all other particles:
    force(i,1)=force(i,1)+sum(ff(i,:,1)); % x component
    force(i,2)=force(i,2)+sum(ff(i,:,2)); % y component
end
end
