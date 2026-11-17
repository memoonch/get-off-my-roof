package com.getoffmyroof.timers
{
   import flash.events.Event;
   
   public class GameTimerEvent extends Event
   {
      
      public static const TICK:String = "tick";
      
      public static const COMPLETE:String = "complete";
      
      public var data:Object;
      
      public function GameTimerEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

