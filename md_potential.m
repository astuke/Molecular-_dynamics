function [ pot, g ] = md_potential( r )
% calculates potential from coordinates

N=length(r(:,1)); % assuming first index to be particle index
pot=sum(sum(r.^2)); % this is x^2+y^2 summed over all particles
a=1000;
for i=1:N,
   for j=i+1:N,
       pot=pot+(-1)^i*(-1)^j/norm(r(i,:)-r(j,:))+a/(norm(r(i,:)-r(j,:)))^2; % Coulomb potential + a/r^2 short repulsive potential
   end
end

if nargout > 1
    g=-md_force(r);
end
end
