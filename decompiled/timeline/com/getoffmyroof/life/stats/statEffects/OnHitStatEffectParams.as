package com.getoffmyroof.life.stats.statEffects
{
   import com.whatthefawk.life.stats.StatEffectParams;
   
   public class OnHitStatEffectParams extends StatEffectParams
   {
      
      public var minDamage:int = -1;
      
      public var scare:int = 0;
      
      public var minWetness:int = -1;
      
      public var damage:int = 0;
      
      public var minScare:int = -1;
      
      public var wetness:int = 0;
      
      public function OnHitStatEffectParams(param1:Object)
      {
         id = "hit";
         name = "Hit";
         super(param1);
      }
   }
}

