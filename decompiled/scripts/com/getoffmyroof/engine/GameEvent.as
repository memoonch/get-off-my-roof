package com.getoffmyroof.engine
{
   import flash.events.Event;
   
   public class GameEvent extends Event
   {
      
      public static const PAUSE:String = "pause";
      
      public var data:Object;
      
      public function GameEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

