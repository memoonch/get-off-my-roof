package org.flintparticles.common.behaviours
{
   import org.flintparticles.common.emitters.Emitter;
   
   public interface Behaviour
   {
      
      function set priority(param1:int) : void;
      
      function addedToEmitter(param1:Emitter) : void;
      
      function get priority() : int;
      
      function removedFromEmitter(param1:Emitter) : void;
   }
}

