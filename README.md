# Molecular_dynamics

This code csimulates the dynamics of particles interacting with the Coulomb potential. While half of the particles are positively charged, the other half is negatively charged so that there is an attraction between some of the particles while others experience a repulsive force. Since in that case the energy of the Coulomb potential is not bounded from below (i.e. can take negative values), a short range repulsive potential of the form a/r^2 is added to regularize the problem. 
