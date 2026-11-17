package com.whatthefawk.weapons.projectile
{
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.life.stats.statEffects.OnHitStatEffect;
   import com.getoffmyroof.life.stats.statEffects.OnHitStatEffectParams;
   import com.getoffmyroof.weapons.projectile.BounceForce;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.entity.CollisionEvent;
   import com.whatthefawk.entity.IMessageReceiver;
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.entity.Telegram;
   import com.whatthefawk.life.stats.StatEffect;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.weapons.HitRecord;
   import com.whatthefawk.weapons.IHittable;
   import com.whatthefawk.weapons.explosion.Explosion;
   import com.whatthefawk.weapons.explosion.ExplosionFactory;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class Projectile extends MovingEntity implements IMessageReceiver, IHittable
   {
      
      private var m_onHitBounceForce:BounceForce;
      
      protected var _gravity:int;
      
      protected var _onExplodeSoundGroup:String;
      
      protected var _explosionFactory:ExplosionFactory;
      
      protected var _onFireSound:String;
      
      protected var _onFireSoundGroup:String;
      
      protected var _shooterID:String;
      
      protected var _explosionAnimationID:String;
      
      private var m_fireParamsClass:Class;
      
      protected var _target:Vector2D;
      
      protected var _explodeOnHit:Boolean;
      
      protected var _hasHit:Dictionary;
      
      protected var _explodeOnDispose:Boolean;
      
      protected var _canHit:Array;
      
      protected var _onHitSoundGroup:String;
      
      protected var _numHit:int;
      
      protected var _shooter:MovingEntity;
      
      protected var _onExplodeSound:String;
      
      protected var _isDead:Boolean;
      
      protected var _audioManager:AudioManager;
      
      protected var _onHitSound:String;
      
      private var m_onHitStatEffectParams:OnHitStatEffectParams;
      
      protected var _dieOnHit:Boolean;
      
      protected var _explosionType:String;
      
      public function Projectile(param1:ProjectileParams)
      {
         super(param1);
         this._audioManager = GameComponents.instance.getAudioManager();
         this.gravity = param1.gravity;
         this._canHit = param1.canHit;
         this._hasHit = new Dictionary();
         this._numHit = 0;
         this._dieOnHit = param1.dieOnHit;
         this._explodeOnHit = param1.explodeOnHit;
         this._explodeOnDispose = param1.explodeOnDispose;
         this._explosionType = param1.explosionType;
         this._explosionFactory = GameComponents.instance.getComponent("ExplosionFactory");
         this.m_fireParamsClass = param1.fireParamsClass;
         this.m_onHitBounceForce = param1.onHitBounceForce;
         this.m_onHitStatEffectParams = param1.onHitStatEffectParams;
         this._onHitSound = param1.onHitSound;
         this._onFireSound = param1.onFireSound;
         this._onExplodeSound = param1.onExplodeSound;
         this._onHitSoundGroup = param1.onHitSoundGroup;
         this._onFireSoundGroup = param1.onFireSoundGroup;
         this._onExplodeSoundGroup = param1.onExplodeSoundGroup;
         this._isDead = false;
      }
      
      public function die() : void
      {
         if(!this._isDead && !isDisposed)
         {
            this._isDead = true;
            isDisposed = true;
            _parent.removeChild(id);
         }
      }
      
      public function get fireParamsClass() : Class
      {
         return this.m_fireParamsClass;
      }
      
      public function get shooter() : MovingEntity
      {
         return this._shooter;
      }
      
      public function getHitRecord(param1:String) : HitRecord
      {
         if(!this._hasHit[param1])
         {
            return null;
         }
         return this._hasHit[param1];
      }
      
      public function get target() : Vector2D
      {
         return this._target;
      }
      
      public function get hasHit() : Dictionary
      {
         return this._hasHit;
      }
      
      public function set gravity(param1:int) : void
      {
         this._gravity = param1;
         removeConstantForce("gravity");
         if(this._gravity != 0)
         {
            addConstantForce(new Vector2D(0,this._gravity),"gravity");
         }
      }
      
      public function get canHit() : Array
      {
         return this._canHit;
      }
      
      public function get shooterID() : String
      {
         return this._shooterID;
      }
      
      public function get numHit() : int
      {
         return this._numHit;
      }
      
      public function get isDead() : Boolean
      {
         return this._isDead;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._audioManager = null;
         this._target = null;
         this._shooter = null;
         this._canHit = null;
         this._hasHit = null;
         this._explosionFactory = null;
         this.m_fireParamsClass = null;
         this.m_onHitBounceForce = null;
         this.m_onHitStatEffectParams = null;
      }
      
      override public function onBoundsRemove(param1:Event = null) : void
      {
         if(this._explodeOnHit)
         {
            this.explode();
         }
         super.onBoundsRemove(param1);
      }
      
      public function fire(param1:ProjectileFireParams) : void
      {
         this._target = param1.target;
         this._shooter = param1.shooter;
         this._shooterID = param1.shooter.id;
         newPos.x = param1.firePosition.x;
         newPos.y = param1.firePosition.y;
         applyForce(param1.fireForce);
         if(this._onFireSound)
         {
            this._audioManager.play(this._onFireSound);
         }
         else if(this._onFireSoundGroup)
         {
            this._audioManager.playRandom(this._onFireSoundGroup);
         }
      }
      
      override public function handleMessage(param1:Telegram) : Boolean
      {
         var _loc2_:String = null;
         if(param1.msg == CollisionEvent.HIT_ENTITY)
         {
            _loc2_ = param1.senderID;
            if(_loc2_ == this._shooterID)
            {
               return true;
            }
            if(!this._hasHit[_loc2_])
            {
               ++this._numHit;
               this._hasHit[_loc2_] = new HitRecord(getTimer());
               applyForce(this.m_onHitBounceForce.calculate());
               if(this._explodeOnHit)
               {
                  this.explode();
               }
               if(this._dieOnHit)
               {
                  this.die();
               }
               if(this._onHitSound)
               {
                  this._audioManager.play(this._onHitSound);
               }
               else if(this._onHitSoundGroup)
               {
                  this._audioManager.playRandom(this._onHitSoundGroup);
               }
            }
            else
            {
               HitRecord(this._hasHit[_loc2_]).update(getTimer());
               if(HitRecord(this._hasHit[_loc2_]).canHit())
               {
                  if(this._onHitSound)
                  {
                     this._audioManager.play(this._onHitSound);
                  }
                  else if(this._onHitSoundGroup)
                  {
                     this._audioManager.playRandom(this._onHitSoundGroup);
                  }
               }
            }
         }
         return true;
      }
      
      override protected function onLifeTimeComplete(param1:Event) : void
      {
         this.die();
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         isCollidable != isResting;
      }
      
      public function get gravity() : int
      {
         return this._gravity;
      }
      
      public function get onHitStatEffect() : StatEffect
      {
         return new OnHitStatEffect(this.m_onHitStatEffectParams);
      }
      
      public function get onHitBounceForce() : BounceForce
      {
         return this.m_onHitBounceForce;
      }
      
      public function explode() : void
      {
         var _loc1_:Explosion = null;
         _loc1_ = this._explosionFactory.getExplosion(this._explosionType);
         _loc1_.newPos.x = currentPos.x;
         _loc1_.newPos.y = currentPos.y;
         _loc1_.shooter = this._shooter;
         _loc1_.shooterID = this._shooterID;
         _loc1_.explode();
         if(this._onExplodeSound)
         {
            this._audioManager.play(this._onExplodeSound);
         }
         else if(this._onExplodeSoundGroup)
         {
            this._audioManager.playRandom(this._onExplodeSoundGroup);
         }
      }
   }
}

