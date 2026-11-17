package com.getoffmyroof.ai.states
{
   import com.getoffmyroof.entity.Player;
   import com.whatthefawk.ai.FSM.AState;
   import com.whatthefawk.entity.CollisionEvent;
   import com.whatthefawk.entity.Telegram;
   import com.whatthefawk.weapons.explosion.Explosion;
   import com.whatthefawk.weapons.projectile.Projectile;
   
   public class PlayerGlobalState extends AState
   {
      
      private var m_player:Player;
      
      public function PlayerGlobalState()
      {
         super();
      }
      
      override public function initialize() : void
      {
         this.m_player = agent;
      }
      
      override public function handleMessage(param1:Telegram) : Boolean
      {
         var _loc2_:* = undefined;
         var _loc3_:Explosion = null;
         var _loc4_:Projectile = null;
         if(param1.msg == CollisionEvent.HIT_ENTITY)
         {
            _loc2_ = param1.extraInfo.entity;
            if(_loc2_ is Explosion)
            {
               _loc3_ = _loc2_;
               if(_loc3_.shooterID == this.m_player.id)
               {
                  return true;
               }
               this.m_player.damage(1);
            }
            if(_loc2_ is Projectile)
            {
               _loc4_ = _loc2_;
               if(_loc4_.shooterID == this.m_player.id)
               {
                  return true;
               }
               this.m_player.damage(1);
            }
            return true;
         }
         return false;
      }
   }
}

