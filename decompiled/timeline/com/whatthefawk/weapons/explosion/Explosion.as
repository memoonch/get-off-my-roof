package com.whatthefawk.weapons.explosion
{
   import com.getoffmyroof.life.stats.statEffects.OnHitStatEffect;
   import com.getoffmyroof.life.stats.statEffects.OnHitStatEffectParams;
   import com.whatthefawk.entity.CollisionEvent;
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.IMessageReceiver;
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.entity.Telegram;
   import com.whatthefawk.life.stats.StatEffect;
   import com.whatthefawk.utils.TickRegulator;
   import com.whatthefawk.weapons.IHittable;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class Explosion extends MovingEntity implements IMessageReceiver, IHittable
   {
      
      protected var _hitTime:int;
      
      public var shooterID:String;
      
      public var shooter:Entity;
      
      protected var _onHitStatEffectParams:OnHitStatEffectParams;
      
      protected var _hitTimer:TickRegulator;
      
      protected var _numHit:int;
      
      protected var _hasHit:Dictionary;
      
      public function Explosion(param1:ExplosionParams)
      {
         super(param1);
         this._numHit = 0;
         this._hasHit = new Dictionary();
         this._onHitStatEffectParams = param1.onHitStatEffectParams;
         this._hitTime = param1.hitTime;
         this._hitTimer = new TickRegulator(this._hitTime);
         this._hitTimer.addEventListener(TickRegulator.TICK,this.onHitTimeComplete,false,0,true);
      }
      
      public function explode() : void
      {
         dispatchEvent(new ExplosionEvent(ExplosionEvent.EXPLODE));
      }
      
      override public function dispose() : void
      {
         this._hasHit = null;
         this._onHitStatEffectParams = null;
         this._hitTimer.removeEventListener(TickRegulator.TICK,this.onHitTimeComplete);
         this._hitTimer = null;
         super.dispose();
      }
      
      protected function onHitTimeComplete(param1:Event) : void
      {
         isCollidable = false;
      }
      
      override protected function onLifeTimeComplete(param1:Event) : void
      {
         if(!isDisposed)
         {
            isDisposed = true;
            _parent.removeChild(id);
         }
      }
      
      override public function update(param1:int) : void
      {
         this._hitTimer.update(param1);
         super.update(param1);
      }
      
      override public function handleMessage(param1:Telegram) : Boolean
      {
         var _loc2_:String = null;
         if(param1.msg == CollisionEvent.HIT_ENTITY)
         {
            _loc2_ = param1.senderID;
            if(_loc2_ == this.shooterID)
            {
               return true;
            }
            if(!this._hasHit[_loc2_])
            {
               ++this._numHit;
               this._hasHit[_loc2_] = 1;
            }
            else
            {
               ++this._hasHit[_loc2_];
            }
         }
         return true;
      }
      
      public function get onHitStatEffect() : StatEffect
      {
         return new OnHitStatEffect(this._onHitStatEffectParams);
      }
   }
}

