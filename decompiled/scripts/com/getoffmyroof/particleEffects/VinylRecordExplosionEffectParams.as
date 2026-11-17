package com.getoffmyroof.particleEffects
{
   import com.whatthefawk.particleEffects.ParticleEffectParams;
   import flash.geom.Point;
   
   public class VinylRecordExplosionEffectParams extends ParticleEffectParams
   {
      
      public var drift:Point = new Point(150,50);
      
      public var lifeTime:int = 2;
      
      public var minBlastDist:int = 80;
      
      public var gravity:int = 200;
      
      public var numOfParticles:int = 4;
      
      public var spread:int = 10;
      
      public var maxBlastDist:int = 200;
      
      public function VinylRecordExplosionEffectParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

