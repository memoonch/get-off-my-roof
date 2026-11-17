package com.whatthefawk.ui
{
   import flash.events.Event;
   
   public class DropEvent extends Event
   {
      
      public static const DROP:String = "drop";
      
      public var data:Object;
      
      public function DropEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         this.data = param2;
         super(param1,param3,param4);
      }
   }
}

