package com.whatthefawk.weapons.projectile
{
   import flash.events.Event;
   
   public class ProjectileWeaponEvent extends Event
   {
      
      public static const FIRE_RATE_TICK:String = "fire_rate_tick";
      
      public static const ACTIVATED:String = "Activated";
      
      public static const DEACTIVATED:String = "Deactivated";
      
      public static const FIRE_SHOT:String = "FireShot";
      
      public static const RELOADING:String = "Reloading";
      
      public static const OUT_OF_AMMO:String = "OutOfAmmo";
      
      public var data:Object;
      
      public function ProjectileWeaponEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

