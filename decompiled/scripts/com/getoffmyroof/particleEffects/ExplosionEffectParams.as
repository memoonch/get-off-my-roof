package com.getoffmyroof.particleEffects
{
   import com.whatthefawk.particleEffects.ParticleEffectParams;
   import flash.geom.Point;
   
   public class ExplosionEffectParams extends ParticleEffectParams
   {
      
      public var drift:Point = new Point(150,50);
      
      public var lifeTime:int = 1.5;
      
      public var minBlastDist:int = 60;
      
      public var gravity:int = 100;
      
      public var numOfParticles:int = 20;
      
      public var spread:int = 10;
      
      public var maxBlastDist:int = 100;
      
      public function ExplosionEffectParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

