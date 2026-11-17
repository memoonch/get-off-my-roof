package com.getoffmyroof.levels
{
   import flash.events.Event;
   
   public class GameLevelEvent extends Event
   {
      
      public static const LEVEL_START:String = "level_start";
      
      public static const LEVEL_COUNTDOWN_START:String = "level_countdown_start";
      
      public static const LEVEL_COUNTDOWN_END:String = "level_countdown_end";
      
      public static const LEVEL_COMPLETE:String = "level_complete";
      
      public static const LEVEL_TIME_UP:String = "level_time_up";
      
      public var data:Object;
      
      public function GameLevelEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

