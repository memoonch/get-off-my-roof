package com.urbansquall.ginger.events
{
   import flash.events.Event;
   
   public class AnimationEvent extends Event
   {
      
      public static const CHANGE:String = "animation_event_change";
      
      public var begin:Boolean;
      
      public var animationID:String;
      
      public function AnimationEvent(param1:String, param2:Boolean, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.begin = param2;
         this.animationID = param3;
      }
   }
}

