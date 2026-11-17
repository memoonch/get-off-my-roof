package com.getoffmyroof.levels.spawners
{
   import flash.events.Event;
   
   public class SpawnerEvent extends Event
   {
      
      public static const SPAWN:String = "spawn";
      
      public static const COMPLETE:String = "complete";
      
      public var data:Object;
      
      public function SpawnerEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

