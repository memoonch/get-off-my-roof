package com.getoffmyroof.particleEffects
{
   import com.getoffmyroof.entity.Pigeon;
   import com.whatthefawk.particleEffects.ParticleEffectParams;
   import flash.geom.Point;
   
   public class FeatherBlastEffectParams extends ParticleEffectParams
   {
      
      public var color:uint = Pigeon.GREY;
      
      public var lifeTime:int = 2.5;
      
      public var minBlastDist:int = 60;
      
      public var numOfFeathers:int = 10;
      
      public var gravity:int = 40;
      
      public var drift:Point = new Point(150,50);
      
      public var spread:int = 20;
      
      public var maxBlastDist:int = 80;
      
      public var drag:int = 1.5;
      
      public function FeatherBlastEffectParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

