package com.whatthefawk.weapons.explosion
{
   import com.getoffmyroof.life.stats.statEffects.OnHitStatEffectParams;
   import com.whatthefawk.entity.MovingEntityParams;
   
   public class ExplosionParams extends MovingEntityParams
   {
      
      public var hitTime:int;
      
      public var onHitStatEffectParams:OnHitStatEffectParams;
      
      public function ExplosionParams(param1:Object = null)
      {
         super();
         this.hitTime = 1000;
         this.onHitStatEffectParams = null;
      }
   }
}

