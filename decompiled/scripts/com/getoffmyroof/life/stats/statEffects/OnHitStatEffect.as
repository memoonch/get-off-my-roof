package com.getoffmyroof.life.stats.statEffects
{
   import com.whatthefawk.life.stats.Stat;
   import com.whatthefawk.life.stats.StatEffect;
   import com.whatthefawk.life.stats.StatEffectEvent;
   import flash.events.Event;
   
   public class OnHitStatEffect extends StatEffect
   {
      
      public var minDamage:int;
      
      public var scare:int;
      
      public var minWetness:int;
      
      public var damage:int;
      
      public var minScare:int;
      
      public var wetness:int;
      
      public function OnHitStatEffect(param1:OnHitStatEffectParams)
      {
         super(param1);
         this.damage = param1.damage;
         this.scare = param1.scare;
         this.wetness = param1.wetness;
         this.minDamage = param1.minDamage == -1 ? param1.damage : param1.minDamage;
         this.minScare = param1.minScare == -1 ? param1.scare : param1.minScare;
         this.minWetness = param1.minWetness == -1 ? param1.wetness : param1.minWetness;
      }
      
      override public function onStart(param1:StatEffectEvent) : void
      {
         statSystem.modifyStat("life",-this.damage,Stat.BOTH_VALUES);
         statSystem.modifyStat("resist",-this.scare,Stat.BOTH_VALUES);
         statSystem.modifyStat("wetness",this.wetness,Stat.BOTH_VALUES);
      }
      
      override public function onComplete(param1:StatEffectEvent) : void
      {
      }
      
      override public function onTick(param1:Event) : void
      {
      }
   }
}

