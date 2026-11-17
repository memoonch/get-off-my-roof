package com.whatthefawk.weapons.explosion
{
   import flash.events.Event;
   
   public class ExplosionEvent extends Event
   {
      
      public static const EXPLODE:String = "explode";
      
      public var data:Object;
      
      public function ExplosionEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

