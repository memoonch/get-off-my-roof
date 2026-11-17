package com.whatthefawk.life
{
   import flash.events.Event;
   
   public class LifeEvent extends Event
   {
      
      public static const DEAD:String = "dead";
      
      public static const REVIVE:String = "revive";
      
      public var data:Object;
      
      public function LifeEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

