package com.getoffmyroof.ai.states
{
   import com.getoffmyroof.ai.states.actions.*;
   import com.getoffmyroof.ai.states.conditions.*;
   import com.getoffmyroof.entity.Pigeon;
   import com.getoffmyroof.life.stats.statEffects.OnHitStatEffect;
   import com.whatthefawk.ai.FSM.AState;
   import com.whatthefawk.entity.CollisionEvent;
   import com.whatthefawk.entity.Telegram;
   import com.whatthefawk.life.stats.Stat;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.weapons.HitRecord;
   import com.whatthefawk.weapons.IHittable;
   import com.whatthefawk.weapons.explosion.Explosion;
   import com.whatthefawk.weapons.melee.MeleeWeapon;
   import com.whatthefawk.weapons.projectile.Projectile;
   
   public class BasicPigeonGlobalState extends AState
   {
      
      private var m_pigeon:Pigeon;
      
      public function BasicPigeonGlobalState()
      {
         super();
      }
      
      override public function initialize() : void
      {
         addAction(agent.state.getAction("PigeonCooSounds"));
      }
      
      override public function handleMessage(param1:Telegram) : Boolean
      {
         var _loc3_:Explosion = null;
         var _loc4_:Vector2D = null;
         var _loc5_:Projectile = null;
         var _loc6_:HitRecord = null;
         var _loc7_:Vector2D = null;
         var _loc8_:OnHitStatEffect = null;
         this.m_pigeon = agent;
         if(this.m_pigeon.isDead)
         {
            return true;
         }
         var _loc2_:Stat = this.m_pigeon.isFlying ? this.m_pigeon.statSystem.getStat("flyResist") : this.m_pigeon.statSystem.getStat("resist");
         if(param1.msg == CollisionEvent.HIT_ENTITY)
         {
            if(this.m_pigeon.statSystem.hasStatEffect("invincibility"))
            {
               return true;
            }
            if(!(param1.extraInfo.entity is IHittable))
            {
               return true;
            }
            if(param1.extraInfo.entity is Explosion)
            {
               _loc3_ = param1.extraInfo.entity;
               _loc4_ = this.m_pigeon.currentPos.subtractedBy(_loc3_.currentPos);
               _loc4_.normalize().times(1000);
               this.m_pigeon.hit(_loc3_.onHitStatEffect,_loc4_);
            }
            if(param1.extraInfo.entity is Projectile)
            {
               _loc5_ = param1.extraInfo.entity;
               _loc6_ = _loc5_.getHitRecord(this.m_pigeon.id);
               if(_loc6_)
               {
                  if(_loc6_.numHits == 1 && _loc6_.timeBetweenHits != 0)
                  {
                     return true;
                  }
                  if(_loc6_.numHits > 1 && _loc6_.timeBetweenHits < 500)
                  {
                     return true;
                  }
               }
               if(_loc5_.shooter.type != "Player")
               {
                  return true;
               }
               this.m_pigeon.hit(_loc5_.onHitStatEffect,_loc5_.velocity);
            }
            if(this.m_pigeon.lifeSystem.isDead)
            {
               this.m_pigeon.state.changeState(this.m_pigeon.state.getState("PigeonDie"));
            }
            else if(_loc2_.value == 0)
            {
               if(!this.m_pigeon.isFlying)
               {
                  this.m_pigeon.fly();
                  this.m_pigeon.state.changeState(this.m_pigeon.state.getState("PigeonFly"));
               }
            }
            return true;
         }
         if(param1.msg == MeleeWeapon.HIT_BY_MELEE)
         {
            if(this.m_pigeon.statSystem.hasStatEffect("invincibility"))
            {
               return true;
            }
            _loc7_ = param1.extraInfo.weaponForce;
            _loc8_ = param1.extraInfo.onHitStatEffect;
            this.m_pigeon.hit(_loc8_,_loc7_);
            if(this.m_pigeon.lifeSystem.isDead)
            {
               this.m_pigeon.state.changeState(this.m_pigeon.state.getState("PigeonDie"));
            }
            return true;
         }
         if(param1.msg == CollisionEvent.HIT_WALL)
         {
            if(!this.m_pigeon.velocity.isZero())
            {
               if(!this.m_pigeon.hasLanded)
               {
                  this.m_pigeon.state.changeState(this.m_pigeon.state.getState("PigeonWander"));
               }
               this.m_pigeon.onLand(param1.extraInfo.wall);
            }
            return true;
         }
         return false;
      }
   }
}

