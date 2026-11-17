package com.urbansquall.ginger.events
{
   import flash.events.Event;
   
   public class FrameEvent extends Event
   {
      
      public static const CHANGE:String = "frame_event_change";
      
      public var frameID:String;
      
      public var begin:Boolean;
      
      public var animationID:String;
      
      public function FrameEvent(param1:String, param2:Boolean, param3:String, param4:String, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         this.begin = param2;
         this.frameID = param3;
         this.animationID = param4;
      }
   }
}

