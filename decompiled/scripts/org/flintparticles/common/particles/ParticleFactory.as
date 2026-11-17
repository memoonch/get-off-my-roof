package org.flintparticles.common.particles
{
   public interface ParticleFactory
   {
      
      function clearAllParticles() : void;
      
      function createParticle() : Particle;
      
      function disposeParticle(param1:Particle) : void;
   }
}

