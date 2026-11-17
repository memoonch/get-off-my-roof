package com.getoffmyroof.rendering
{
   import com.getoffmyroof.entity.Pigeon;
   import com.getoffmyroof.entity.PigeonEvent;
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.rendering.AnimationRenderer;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.filters.BevelFilter;
   
   public class PigeonRenderer extends AnimationRenderer
   {
      
      private static const PIGEON_WET_FILTER:BevelFilter = new BevelFilter(10,1,3302911,1,3302911,1,10,10,0.5);
      
      private var m_pigeon:Pigeon;
      
      public function PigeonRenderer(param1:Entity, param2:GameCamera, param3:DisplayObjectContainer, param4:Object = null)
      {
         super(param1,param2,param3,param4);
         this.m_pigeon = param1 as Pigeon;
         this.m_pigeon.addEventListener(PigeonEvent.ATTACK,this.onPigeonAttack,false,0,true);
         this.m_pigeon.addEventListener(PigeonEvent.DIE,this.onPigeonDie,false,0,true);
         this.m_pigeon.addEventListener(PigeonEvent.FLY,this.onPigeonFly,false,0,true);
         this.m_pigeon.addEventListener(PigeonEvent.HIT,this.onPigeonHit,false,0,true);
         this.m_pigeon.addEventListener(PigeonEvent.JUMP,this.onPigeonJump,false,0,true);
         this.m_pigeon.addEventListener(PigeonEvent.LAND,this.onPigeonLand,false,0,true);
         this.m_pigeon.addEventListener(PigeonEvent.LANDING,this.onPigeonLanding,false,0,true);
         this.m_pigeon.addEventListener(PigeonEvent.WET,this.onPigeonWet,false,0,true);
         this.m_pigeon.addEventListener(PigeonEvent.DRY,this.onPigeonDry,false,0,true);
      }
      
      protected function onPigeonLand(param1:Event) : void
      {
         if(_animationPlayer.currentAnimationID != "PigeonIdle")
         {
            _animationPlayer.play("PigeonIdle");
         }
      }
      
      protected function onPigeonLanding(param1:Event) : void
      {
         if(_animationPlayer.currentAnimationID != "PigeonLanding" && _animationPlayer.currentAnimationID != "PigeonHit")
         {
            _animationPlayer.play("PigeonLanding");
         }
      }
      
      protected function onPigeonJump(param1:Event) : void
      {
         if(_animationPlayer.currentAnimationID != "PigeonHop")
         {
            _animationPlayer.play("PigeonHop");
         }
      }
      
      protected function onPigeonFly(param1:Event) : void
      {
         if(_animationPlayer.currentAnimationID != "PigeonFly" && _animationPlayer.currentAnimationID != "PigeonHit")
         {
            _animationPlayer.play("PigeonFly");
         }
      }
      
      protected function onPigeonDie(param1:Event) : void
      {
         if(_animationPlayer.currentAnimationID != "PigeonDeath")
         {
            _animationPlayer.play("PigeonDeath");
         }
      }
      
      protected function onPigeonWet(param1:Event) : void
      {
         var _loc2_:BevelFilter = PIGEON_WET_FILTER;
         _loc2_.angle = Math.random() * 360;
         _animationPlayer.filters = [_loc2_];
      }
      
      protected function onPigeonDry(param1:Event) : void
      {
         _animationPlayer.filters = null;
      }
      
      protected function onPigeonAttack(param1:PigeonEvent) : void
      {
         var _loc2_:String = "PigeonPoo";
         if(param1.data.animationID == "PigeonThrowRockWeapon")
         {
            _loc2_ = "PigeonThrowRock";
         }
         if(_animationPlayer.currentAnimationID != _loc2_)
         {
            _animationPlayer.play(_loc2_);
         }
         if(this.m_pigeon.isFlying)
         {
            _animationPlayer.queue("PigeonFly");
         }
      }
      
      protected function onPigeonHit(param1:Event) : void
      {
         if(_animationPlayer.currentAnimationID != "PigeonHit")
         {
            _animationPlayer.play("PigeonHit");
         }
         _animationPlayer.queue("PigeonFly");
      }
      
      override public function dispose() : void
      {
         this.m_pigeon.removeEventListener(PigeonEvent.ATTACK,this.onPigeonAttack);
         this.m_pigeon.removeEventListener(PigeonEvent.DIE,this.onPigeonDie);
         this.m_pigeon.removeEventListener(PigeonEvent.FLY,this.onPigeonFly);
         this.m_pigeon.removeEventListener(PigeonEvent.HIT,this.onPigeonHit);
         this.m_pigeon.removeEventListener(PigeonEvent.JUMP,this.onPigeonJump);
         this.m_pigeon.removeEventListener(PigeonEvent.LAND,this.onPigeonLand);
         this.m_pigeon.removeEventListener(PigeonEvent.LANDING,this.onPigeonLanding);
         this.m_pigeon.removeEventListener(PigeonEvent.WET,this.onPigeonWet);
         this.m_pigeon.removeEventListener(PigeonEvent.DRY,this.onPigeonDry);
         this.m_pigeon = null;
         super.dispose();
      }
   }
}

