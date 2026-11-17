package com.getoffmyroof.rewards
{
   import flash.events.Event;
   
   public class RewardSystemEvent extends Event
   {
      
      public static const POINTS:String = "points";
      
      public static const COMBO:String = "combo";
      
      public var data:Object;
      
      public function RewardSystemEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

