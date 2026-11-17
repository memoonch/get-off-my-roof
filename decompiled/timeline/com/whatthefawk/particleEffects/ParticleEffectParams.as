package com.whatthefawk.particleEffects
{
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.utils.Params;
   
   public class ParticleEffectParams extends Params
   {
      
      public var target:Vector2D;
      
      public var emitters:Array = [];
      
      public function ParticleEffectParams(param1:Object)
      {
         super(param1);
      }
   }
}

