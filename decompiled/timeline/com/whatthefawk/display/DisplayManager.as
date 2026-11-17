package com.whatthefawk.display
{
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.entity.GameWorld;
   import com.whatthefawk.particleEffects.ParticleEffect;
   import flash.utils.Dictionary;
   
   public class DisplayManager
   {
      
      private var m_displays:Dictionary;
      
      private var m_gameWorld:GameWorld;
      
      public function DisplayManager()
      {
         super();
         this.m_displays = new Dictionary();
      }
      
      public function update(param1:int) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.m_displays)
         {
            _loc2_.update(param1);
         }
      }
      
      public function addDisplay(param1:String, param2:*) : void
      {
         this.m_displays[param1] = param2;
      }
      
      public function addParticleEffect(param1:String, param2:ParticleEffect) : void
      {
         if(!this.m_displays[param1])
         {
            throw new Error("<DisplayManager::addParticleEffect> No Particle Effect with id " + param1);
         }
         this.m_displays[param1].addParticleEffect(param2);
      }
      
      public function setGameCamera(param1:GameCamera) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.m_displays)
         {
            _loc2_.setGameCamera(param1);
         }
      }
      
      public function getDisplay(param1:String) : *
      {
         if(!this.m_displays[param1])
         {
            return;
         }
         return this.m_displays[param1];
      }
   }
}

