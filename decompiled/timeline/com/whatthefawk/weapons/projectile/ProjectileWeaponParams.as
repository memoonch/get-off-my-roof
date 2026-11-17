package com.whatthefawk.weapons.projectile
{
   import com.whatthefawk.entity.Boid;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.utils.Params;
   import flash.display.Sprite;
   
   public class ProjectileWeaponParams extends Params
   {
      
      public var agent:Boid;
      
      public var customClass:Class;
      
      public var fireAt:String;
      
      public var name:String;
      
      public var ammoUsedPerShot:int;
      
      public var target:Vector2D;
      
      public var fireStyle:String;
      
      public var minFireForce:int;
      
      public var ammoType:String;
      
      public var beforeFireDelay:int;
      
      public var fireRate:int;
      
      public var id:String;
      
      public var burstDelay:int;
      
      public var ammo:int;
      
      public var fireForce:int;
      
      public var projectileFactory:ProjectileWeaponFactory;
      
      public var ammoMax:int;
      
      public var fireOffset:Vector2D;
      
      public var reloadDelay:int;
      
      public var numBulletsPerShot:int;
      
      public var fireDirection:Vector2D;
      
      public var inventoryIcon:Sprite;
      
      public var numShotsPerBurst:int;
      
      public var afterFireDelay:int;
      
      public var fireCone:int;
      
      public function ProjectileWeaponParams(param1:Object = null)
      {
         super();
         this.customClass = ProjectileWeapon;
         this.target = new Vector2D();
         this.fireAt = ProjectileWeapon.FIRE_UP;
         this.fireRate = 1000;
         this.fireStyle = ProjectileWeapon.SEMI_AUTOMATIC;
         this.fireOffset = new Vector2D();
         this.beforeFireDelay = 0;
         this.afterFireDelay = 0;
         this.numShotsPerBurst = 0;
         this.numBulletsPerShot = 1;
         applyParams(param1);
      }
   }
}

