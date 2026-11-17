package com.whatthefawk.weapons
{
   import flash.events.Event;
   
   public class WeaponSystemEvent extends Event
   {
      
      public static const ACTIVATED:String = "activated";
      
      public static const DEACTIVATED:String = "deactivated";
      
      public static const SWITCH_WEAPON:String = "switch_weapon";
      
      public var data:Object;
      
      public function WeaponSystemEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

