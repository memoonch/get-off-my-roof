package com.whatthefawk.audio
{
   import flash.events.Event;
   
   public class AudioEvent extends Event
   {
      
      public static const MUTE:String = "mute";
      
      public static const UNMUTE:String = "unmute";
      
      public static const PAUSE:String = "pause";
      
      public static const UNPAUSE:String = "unpause";
      
      public var data:Object;
      
      public function AudioEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

