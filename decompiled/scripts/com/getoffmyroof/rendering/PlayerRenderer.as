package com.getoffmyroof.rendering
{
   import com.getoffmyroof.entity.Player;
   import com.getoffmyroof.entity.PlayerEvent;
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.rendering.AnimationRenderer;
   import flash.display.DisplayObjectContainer;
   
   public class PlayerRenderer extends AnimationRenderer
   {
      
      private var m_invincibleAnimationTime:int = 0;
      
      private var m_currentUseItemAnimation:String = "";
      
      private var m_player:Player;
      
      private var m_invincibleAnimationSpeed:int = 1;
      
      private var m_currentAttackAnimation:String = "";
      
      public function PlayerRenderer(param1:Player, param2:GameCamera, param3:DisplayObjectContainer, param4:Object)
      {
         super(param1,param2,param3,param4);
         this.m_player = param1;
         this.m_player.addEventListener(PlayerEvent.ATTACK,this.onPlayerAttack,false,0,true);
         this.m_player.addEventListener(PlayerEvent.DIE,this.onPlayerDie,false,0,true);
         this.m_player.addEventListener(PlayerEvent.HIT,this.onPlayerHit,false,0,true);
         this.m_player.addEventListener(PlayerEvent.IDLE,this.onPlayerIdle,false,0,true);
         this.m_player.addEventListener(PlayerEvent.JUMP,this.onPlayerJump,false,0,true);
         this.m_player.addEventListener(PlayerEvent.LAND,this.onPlayerLand,false,0,true);
         this.m_player.addEventListener(PlayerEvent.USE_WETNAP,this.onPlayerUseWetnap,false,0,true);
         this.m_player.addEventListener(PlayerEvent.WALK,this.onPlayerWalk,false,0,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.m_player.statSystem.hasStatEffect("invincibility"))
         {
            this.m_invincibleAnimationTime += this.m_invincibleAnimationSpeed;
            _container.alpha = Math.sin(this.m_invincibleAnimationTime);
         }
         else
         {
            this.m_invincibleAnimationTime = 0;
            this.fadeTo(1,0.3);
         }
      }
      
      protected function onPlayerWalk(param1:PlayerEvent) : void
      {
         if(_animationPlayer.currentAnimationID != "PlayerWalk" && _animationPlayer.currentAnimationID != "PlayerJump" && _animationPlayer.currentAnimationID != "PlayerHit" && _animationPlayer.currentAnimationID != this.m_currentAttackAnimation)
         {
            _animationPlayer.play("PlayerWalk");
         }
      }
      
      protected function onPlayerHit(param1:PlayerEvent) : void
      {
         if(_animationPlayer.currentAnimationID != "PlayerHit")
         {
            _animationPlayer.play("PlayerHit");
         }
      }
      
      protected function onPlayerAttack(param1:PlayerEvent) : void
      {
         if(!param1.data || !param1.data.animationID)
         {
            return;
         }
         var _loc2_:String = param1.data.animationID;
         if(_animationPlayer.currentAnimationID != _loc2_)
         {
            this.m_currentAttackAnimation = _loc2_;
            _animationPlayer.play(_loc2_);
         }
      }
      
      protected function onPlayerLand(param1:PlayerEvent) : void
      {
      }
      
      protected function fadeTo(param1:Number, param2:Number = 0.1, param3:Number = 0.1) : void
      {
         if(_container.alpha == param1)
         {
            return;
         }
         if(_container.alpha < param1 + param3 && _container.alpha > param1 - param3)
         {
            param2 = param1;
            return;
         }
         if(_container.alpha < param1 + param2 && _container.alpha > param1 - param2)
         {
            param2 = param3;
         }
         if(_container.alpha > param1)
         {
            _container.alpha -= param2;
         }
         if(_container.alpha < param1)
         {
            _container.alpha += param2;
         }
      }
      
      protected function onPlayerDie(param1:PlayerEvent) : void
      {
         if(_animationPlayer.currentAnimationID != "PlayerDeath")
         {
            _animationPlayer.play("PlayerDeath");
         }
      }
      
      protected function onPlayerIdle(param1:PlayerEvent) : void
      {
         if(_animationPlayer.currentAnimationID != "PlayerIdle" && _animationPlayer.currentAnimationID != "PlayerHit" && _animationPlayer.currentAnimationID != "PlayerWipeFace" && _animationPlayer.currentAnimationID != this.m_currentAttackAnimation && _animationPlayer.currentAnimationID != this.m_currentUseItemAnimation)
         {
            _animationPlayer.play("PlayerIdle");
         }
      }
      
      protected function onPlayerJump(param1:PlayerEvent) : void
      {
         if(_animationPlayer.currentAnimationID != "PlayerJump")
         {
            _animationPlayer.play("PlayerJump");
         }
      }
      
      protected function onPlayerUseWetnap(param1:PlayerEvent) : void
      {
         if(_animationPlayer.currentAnimationID != "PlayerWipeFace")
         {
            _animationPlayer.play("PlayerWipeFace");
         }
      }
      
      override public function dispose() : void
      {
         this.m_player.removeEventListener(PlayerEvent.ATTACK,this.onPlayerAttack);
         this.m_player.removeEventListener(PlayerEvent.DIE,this.onPlayerDie);
         this.m_player.removeEventListener(PlayerEvent.HIT,this.onPlayerHit);
         this.m_player.removeEventListener(PlayerEvent.IDLE,this.onPlayerIdle);
         this.m_player.removeEventListener(PlayerEvent.JUMP,this.onPlayerJump);
         this.m_player.removeEventListener(PlayerEvent.LAND,this.onPlayerLand);
         this.m_player.removeEventListener(PlayerEvent.USE_WETNAP,this.onPlayerUseWetnap);
         this.m_player.removeEventListener(PlayerEvent.WALK,this.onPlayerWalk);
         this.m_player = null;
         super.dispose();
      }
   }
}

