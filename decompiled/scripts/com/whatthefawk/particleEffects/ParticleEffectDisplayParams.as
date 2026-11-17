package com.whatthefawk.particleEffects
{
   import com.whatthefawk.entity.EntityParams;
   import com.whatthefawk.entity.GameCamera;
   
   public class ParticleEffectDisplayParams extends EntityParams
   {
      
      public var camera:GameCamera;
      
      public var maxParticleEffects:int = 30;
      
      public var maxParticles:int = 500;
      
      public function ParticleEffectDisplayParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

