package com.whatthefawk.life.stats.statEffects
{
   import com.whatthefawk.life.stats.StatEffect;
   import com.whatthefawk.life.stats.StatEffectParams;
   
   public class InvincibilityStatEffect extends StatEffect
   {
      
      public function InvincibilityStatEffect(param1:StatEffectParams)
      {
         super(param1);
         _id = "invincibility";
         _name = "Invincibility";
      }
   }
}

