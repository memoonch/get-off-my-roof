package com.whatthefawk.weapons.projectile
{
   import com.whatthefawk.math.MathUtils;
   import com.whatthefawk.math.Vector2D;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   
   public class ProjectileWeapon extends EventDispatcher
   {
      
      public static const AUTOMATIC:String = "automatic";
      
      public static const SEMI_AUTOMATIC:String = "semi_automatic";
      
      public static const FIRE_UP:* = "fire_up";
      
      public static const FIRE_DOWN:* = "fire_down";
      
      public static const FIRE_LEFT:* = "fire_left";
      
      public static const FIRE_RIGHT:* = "fire_right";
      
      public static const FIRE_AT_TARGET:* = "fire_at_target";
      
      public static const FIRE_AT_HEADING:* = "fire_at_heading";
      
      public static const FIRE_IN_DIRECTION:* = "fire_in_direction";
      
      protected var _minFireForce:int;
      
      protected var _agent:*;
      
      protected var _ammoType:String;
      
      protected var _fireOffset:Vector2D;
      
      protected var _fireTime:int;
      
      public var target:Vector2D;
      
      protected var _fireRate:int;
      
      protected var _afterFireDelay:int;
      
      protected var _fireStyle:String;
      
      protected var _finalFireForce:Vector2D;
      
      protected var _isFiring:Boolean;
      
      protected var _fireAt:String;
      
      protected var _reloadDelay:int;
      
      protected var _ammo:int;
      
      protected var _isTriggerPulled:Boolean;
      
      protected var _id:String;
      
      protected var _ammoUsedPerShot:int;
      
      protected var _numShotsPerBurst:int;
      
      protected var _fireForce:int;
      
      protected var _fireCone:int;
      
      protected var _numShotsFired:int;
      
      protected var _burstDelay:int;
      
      protected var _triggerTime:int;
      
      protected var _canFire:Boolean;
      
      protected var _projectileFactory:ProjectileWeaponFactory;
      
      protected var _name:String;
      
      protected var _numBulletsPerShot:int;
      
      protected var _beforeFireDelay:int;
      
      protected var _fireDirection:Vector2D;
      
      protected var _inventoryIcon:Sprite;
      
      protected var _ammoMax:int;
      
      public function ProjectileWeapon(param1:ProjectileWeaponParams = null)
      {
         super();
         this.target = param1.target;
         this._agent = param1.agent;
         this._projectileFactory = param1.projectileFactory;
         this._id = param1.id;
         this._name = param1.name;
         this._inventoryIcon = param1.inventoryIcon;
         this._fireAt = param1.fireAt;
         this._fireRate = param1.fireRate;
         this._fireCone = param1.fireCone;
         this._fireStyle = param1.fireStyle;
         this._fireForce = param1.fireForce;
         this._minFireForce = param1.minFireForce;
         this._finalFireForce = new Vector2D();
         this._fireDirection = param1.fireDirection;
         this._fireOffset = param1.fireOffset;
         this._beforeFireDelay = param1.beforeFireDelay;
         this._afterFireDelay = param1.afterFireDelay;
         this._triggerTime = 0;
         this._numShotsFired = 0;
         this._numBulletsPerShot = param1.numBulletsPerShot;
         this._numShotsPerBurst = param1.numShotsPerBurst;
         if(this._numShotsPerBurst < 1)
         {
            this._numShotsPerBurst = this._fireStyle == ProjectileWeapon.SEMI_AUTOMATIC ? 1 : 0;
         }
         this._burstDelay = param1.burstDelay;
         this._reloadDelay = param1.reloadDelay;
         this._ammoType = param1.ammoType;
         this._ammo = param1.ammo;
         this._ammoMax = param1.ammoMax;
         this._ammoUsedPerShot = param1.ammoUsedPerShot;
         this._canFire = true;
         this._isFiring = false;
         this._isTriggerPulled = false;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      private function fireProjectiles(param1:int, param2:Vector2D) : void
      {
         var _loc3_:Number = this._fireCone / (this._numBulletsPerShot - 1);
         param2.rotate(this._fireCone * 0.5);
         var _loc4_:int = 0;
         while(_loc4_ < this._numBulletsPerShot)
         {
            this.fireProjectile(param1,param2);
            param2.rotate(-_loc3_);
            _loc4_++;
         }
      }
      
      public function reload(param1:int) : void
      {
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function dispose() : void
      {
         this.target = null;
         this._agent = null;
         this._projectileFactory = null;
         this._finalFireForce = null;
         this._fireDirection = null;
         this._fireOffset = null;
      }
      
      public function get canFire() : Boolean
      {
         return this._canFire;
      }
      
      public function get ammoType() : String
      {
         return this._ammoType;
      }
      
      public function fire() : void
      {
         var _loc1_:Vector2D = new Vector2D();
         ++this._numShotsFired;
         switch(this._fireAt)
         {
            case ProjectileWeapon.FIRE_UP:
               _loc1_.set(0,-1);
               break;
            case ProjectileWeapon.FIRE_DOWN:
               _loc1_.set(0,1);
               break;
            case ProjectileWeapon.FIRE_LEFT:
               _loc1_.set(-1,0);
               break;
            case ProjectileWeapon.FIRE_RIGHT:
               _loc1_.set(1,0);
               break;
            case ProjectileWeapon.FIRE_AT_HEADING:
               _loc1_.set(this._agent.heading);
               break;
            case ProjectileWeapon.FIRE_AT_TARGET:
               _loc1_.set(this.target.subtractedBy(this._agent.currentPos).normalize());
               break;
            case ProjectileWeapon.FIRE_IN_DIRECTION:
               _loc1_.set(this._fireDirection);
         }
         if(this._numBulletsPerShot > 1)
         {
            this.fireProjectiles(this._fireForce,_loc1_);
         }
         else
         {
            this.fireProjectile(this._fireForce,_loc1_);
         }
      }
      
      public function get isFiring() : Boolean
      {
         return this._isFiring;
      }
      
      private function fireProjectile(param1:int, param2:Vector2D) : void
      {
         var _loc3_:int = this._minFireForce ? MathUtils.randomRange(this._minFireForce,this._fireForce) : param1;
         var _loc4_:Vector2D = param2.multipliedBy(_loc3_);
         var _loc5_:Vector2D = this._agent.currentPos.addedTo(this._fireOffset);
         var _loc6_:Projectile = this._projectileFactory.getProjectile(this._ammoType);
         _loc6_.fire(new _loc6_.fireParamsClass({
            "target":this.target,
            "shooter":this._agent,
            "fireForce":_loc4_,
            "firePosition":_loc5_
         }));
      }
      
      public function update(param1:int) : void
      {
         if(this._isTriggerPulled)
         {
            this._triggerTime += param1;
            if(this._canFire && this._triggerTime >= this._beforeFireDelay)
            {
               this._isFiring = true;
            }
         }
         if(this._isFiring)
         {
            if(this._numShotsFired == 0)
            {
               this.fire();
            }
            this._fireTime += param1;
            if(this._fireTime >= this._fireRate)
            {
               this._fireTime -= this._fireRate;
               this.fire();
               dispatchEvent(new ProjectileWeaponEvent(ProjectileWeaponEvent.FIRE_RATE_TICK));
            }
         }
         if(!this._canFire)
         {
            this._fireTime += param1;
            if(this._fireTime >= this._fireRate + this._afterFireDelay)
            {
               this._fireTime = 0;
               this._triggerTime = 0;
               this._canFire = true;
            }
         }
         if(this._numShotsPerBurst > 0 && this._numShotsFired >= this._numShotsPerBurst)
         {
            this._canFire = false;
            this._isFiring = false;
            this._numShotsFired = 0;
            if(this._fireStyle == ProjectileWeapon.SEMI_AUTOMATIC)
            {
               this._isTriggerPulled = false;
            }
         }
      }
      
      public function get isTriggerPulled() : Boolean
      {
         return this._isTriggerPulled;
      }
      
      public function activate() : void
      {
         if(!this._canFire && this._fireStyle == ProjectileWeapon.SEMI_AUTOMATIC)
         {
            return;
         }
         this._isTriggerPulled = true;
         this._numShotsFired = 0;
      }
      
      public function deactivate() : void
      {
         this._triggerTime = 0;
         this._isTriggerPulled = false;
         if(this._isFiring && this._fireStyle == ProjectileWeapon.AUTOMATIC)
         {
            this._canFire = false;
            this._isFiring = false;
         }
      }
      
      public function get inventoryIcon() : Sprite
      {
         return this._inventoryIcon;
      }
   }
}

